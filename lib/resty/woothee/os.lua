local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_windows(ua, result)
  if not string.find(ua, 'Windows', 1, true) then
    return false;
  end

  if string.find(ua, 'Xbox', 1, true) then
    local d = dataset.get("Xbox360")
    if string.find(ua, 'Xbox; Xbox One)', 1, true) then
      d = dataset.get("XboxOne")
    end
    util.update_map(result, d)
    return true
  end

  local data = dataset.get('Win');
  local match, err = ngx.re.match(ua, 'Windows ([ .a-zA-Z0-9]+)[;)]', "o")
  if not match then
    -- Windows, but version unknown
    util.update_category(result, data[dataset.KEY_CATEGORY]);
    util.update_os(result, data[dataset.KEY_NAME]);
    return true
  end

  local version = match[1]
  if version == 'NT 10.0' then
    data = dataset.get('Win10')
  elseif version == 'NT 6.3' then
    data = dataset.get('Win8.1')
  elseif version == 'NT 6.2' then
    data = dataset.get('Win8') -- "NT 6.2; ARM;" means Windows RT, oh....
  elseif version == 'NT 6.1' then
    data = dataset.get('Win7')
  elseif version == 'NT 6.0' then
    data = dataset.get('WinVista')
  elseif version == 'NT 5.1' then
    data = dataset.get('WinXP')
  elseif version == 'NT 5.0' then
    data = dataset.get('Win2000')
  elseif version == 'NT 4.0' then
    data = dataset.get('WinNT4')
  elseif version == '98' then
    data = dataset.get('Win98')
  elseif version == '95' then
    data = dataset.get('Win95')
  elseif version == 'CE' then
    data = dataset.get('WinCE')
  else
    match, err = ngx.re.match(version, [[^Phone(?: OS)? ([.0-9]+)]], "o")
    if match then
      data = dataset.get('WinPhone')
      version = match[1]
    end
  end

  util.update_category(result, data[dataset.KEY_CATEGORY]);
  util.update_os(result, data[dataset.KEY_NAME]);
  util.update_os_version(result, version);
  return true;
end

function _M.challenge_osx(ua, result)
  -- Opens a file in append mode

  if not string.find(ua, 'Mac OS X', 1, true) then
    return false
  end

  local dummy = nil
  local data = dataset.get('OSX');
  local version = nil
  local match = nil

  if string.find(ua, 'like Mac OS X', 1, true) then
    if string.find(ua, 'iPhone;', 1, true) then
      data = dataset.get('iPhone')
    elseif string.find(ua, 'iPad;', 1, true) then
      data = dataset.get('iPad')
    elseif string.find(ua, 'iPod', 1, true) then
      data = dataset.get('iPod')
    end

    local match, err = ngx.re.match(ua, [[; CPU(?: iPhone)? OS (\d+_\d+(?:_\d+)?) like Mac OS X]], "o")
    if match and match[1] then
      version, dummy = string.gsub(match[1], "_", ".")
    end

  else
    local match, err = ngx.re.match(ua, [[Mac OS X (10[._]\d+(?:[._]\d+)?)(?:\)|;)]], "o")
    if match and match[1] then
      version, dummy = string.gsub(match[1], "_", ".")
    end
  end

  util.update_category(result, data[dataset.KEY_CATEGORY]);
  util.update_os(result, data[dataset.KEY_NAME]);
  if version then
    util.update_os_version(result, version);
  end
  return true
end


function _M.challenge_linux(ua, result)
  if not string.find(ua, 'Linux', 1, true) then
    return false
  end

  local data = dataset.get('Linux');
  local os_version = nil

  if string.find(ua, 'Android', 1, true) then
    data = dataset.get('Android');
    local match, err = ngx.re.match(ua, [[Android[- ](\d+(.\d+(?:.\d+)?)?)]], "o")
    if match then
      os_version = match[1]
    end
  end

  util.update_category(result, data[dataset.KEY_CATEGORY]);
  util.update_os(result, data[dataset.KEY_NAME]);
  if os_version then
    util.update_os_version(result, os_version);
  end
  return true
end


function _M.challenge_smart_phone(ua, result)
  local data, os_version, match, err = nil

  if string.find(ua, 'iPhone', 1, true) then
    data = dataset.get('iPhone')
  elseif string.find(ua, 'iPad', 1, true) then
    data = dataset.get('iPad')
  elseif string.find(ua, 'iPod', 1, true) then
    data = dataset.get('iPod')
  elseif string.find(ua, 'Android', 1, true) then
    data = dataset.get('Android')
  elseif string.find(ua, 'CFNetwork', 1, true) then
    data = dataset.get('iOS')
  elseif string.find(ua, 'BB10', 1, true) then
    data = dataset.get('BlackBerry10')
    match, err = ngx.re.match(ua, [[Version/([.0-9]+) ]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'BlackBerry', 1, true) then
    data = dataset.get('BlackBerry')
    match, err = ngx.re.match(ua, [[BlackBerry(?:\d+)/([.0-9]+) ]], "o")
    if match then
      os_version = match[1]
    end
  end

  if result[dataset.KEY_NAME] and result[dataset.KEY_NAME] == dataset.get('Firefox')[dataset.KEY_NAME] then
    -- Firefox OS specific pattern
    -- http://lawrencemandel.com/2012/07/27/decision-made-firefox-os-user-agent-string/
    -- https://github.com/woothee/woothee/issues/2
    match, err = ngx.re.match(ua, [[^Mozilla/[.0-9]+ \((?:Mobile|Tablet);(?:.*;)? rv:([.0-9]+)\) Gecko/[.0-9]+ Firefox/[.0-9]+$]], "o")
    if match then
      data = dataset.get('FirefoxOS');
      os_version = match[1]
    end
  end

  if not data then
    return false
  end

  util.update_category(result, data[dataset.KEY_CATEGORY])
  util.update_os(result, data[dataset.KEY_NAME])
  if os_version then
    util.update_os_version(result, os_version)
  end
  return true
end

function _M.challenge_mobile_phone(ua, result)
  if string.find(ua, 'KDDI-', 1, true) then
    local match, err = ngx.re.match(ua, [[KDDI-([^- /;()"']+)]], "o")
    if match then
      local term = match[1];
      local data = dataset.get('au');
      util.update_category(result, data[dataset.KEY_CATEGORY])
      util.update_os(result, data[dataset.KEY_OS])
      util.update_version(result, term)
      return true
    end
  elseif string.find(ua, 'WILLCOM', 1, true) or string.find(ua, 'DDIPOCKET', 1, true) then
    local match, err = ngx.re.match(ua, [[(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)]], "o")
    if match then
      local term = match[1];
      local data = dataset.get('willcom');
      util.update_category(result, data[dataset.KEY_CATEGORY])
      util.update_os(result, data[dataset.KEY_OS])
      util.update_version(result, term)
      return true
    end
  elseif string.find(ua, 'SymbianOS', 1, true) then
    local data = dataset.get('SymbianOS');
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return true
  elseif string.find(ua, 'Google Wireless Transcoder', 1, true) then
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Google')
    return true
  elseif string.find(ua, 'Naver Transcoder', 1, true) then
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Naver')
    return true
  end

  return false
end

function _M.challenge_appliance(ua, result)
  if string.find(ua, 'Nintendo DSi;', 1, true) then
    local data = dataset.get('NintendoDSi');
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return true
  elseif string.find(ua, 'Nintendo Wii;', 1, true) then
    local data = dataset.get('NintendoWii');
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_OS])
    return true
  end

  return false
end

function _M.challenge_misc(ua, result)
  local data, os_version, match, err = nil

  if string.find(ua, '(Win98;', 1, true) then
    data = dataset.get('Win98');
    os_version = '98'
  elseif string.find(ua, 'Macintosh; U; PPC;', 1, true) then
    data = dataset.get('MacOS');
    match, err = ngx.re.match(ua, [[rv:(\d+.\d+.\d+)]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'Mac_PowerPC', 1, true) then
    data = dataset.get('MacOS');
  elseif string.find(ua, 'X11; FreeBSD ', 1, true) then
    data = dataset.get('BSD');
    match, err = ngx.re.match(ua, [[FreeBSD ([^;\)]+);]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'X11; CrOS ', 1, true) then
    data = dataset.get('ChromeOS');
    match, err = ngx.re.match(ua, [[CrOS ([^\)]+)\)]], "o")
    if match then
      os_version = match[1]
    end
  end

  if data then
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_NAME])
    if os_version then
      util.update_os_version(result, os_version);
    end
    return true
  end

  return false
end

return _M
