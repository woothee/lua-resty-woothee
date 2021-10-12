local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_MSIE(ua, result)
  if not string.find(ua, 'compatible; MSIE', 1, true) and not string.find(ua, 'Trident/', 1, true) and not string.find(ua, 'IEMobile/', 1, true) then
    return false;
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[MSIE ([.0-9]+);]], "o")
  if match then
    version = match[1]
  else
    local match1, err1 = ngx.re.match(ua, [[Trident/([.0-9]+);]], "o")
    local match2, err2 = ngx.re.match(ua, [[ rv:([.0-9]+)]], "o")
    if match1 and match2 then
      version = match2[1]
    else
      match, err = ngx.re.match(ua, [[IEMobile/([.0-9]+);]], "o")
      if match then
        version = match[1]
      end
    end
  end

  util.update_map(result, dataset.get('MSIE'))
  util.update_version(result, version)
  return true;
end


function _M.challenge_safari_chrome(ua, result)
  if not string.find(ua, 'Safari/', 1, true) then
    return false
  elseif string.find(ua, 'Chrome', 1, true) and string.find(ua, 'wv', 1, true) then
    return false
  elseif string.find(ua, 'Google Web Preview', 1, true) then
    -- really????
    return false
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[(?:Edge|Edg|EdgiOS|EdgA)\/([.0-9]+)]], "o")
  if match then
    version = match[1]
    util.update_map(result, dataset.get('Edge'))
    util.update_version(result, version)
    return true
  end

  local match, err = ngx.re.match(ua, [[FxiOS\/([.0-9]+)]], "o")
  if match then
    version = match[1]
    util.update_map(result, dataset.get('Firefox'))
    util.update_version(result, version)
    return true
  end

  local match, err = ngx.re.match(ua, [[(?:Chrome|CrMo|CriOS)/([.0-9]+)]], "o")
  if match then
    local match_ob, err = ngx.re.match(ua, [[OPR/([.0-9]+)]], "o")
    if match_ob then
      -- Opera w/ blink
      version = match_ob[1]
      util.update_map(result, dataset.get('Opera'))
      util.update_version(result, version)
      return true
    end

    -- Chrome
    version = match[1]
    util.update_map(result, dataset.get('Chrome'))
    util.update_version(result, version)
    return true
  end

  local match, err = ngx.re.match(ua, [[GSA\/([.0-9]+)]], "o")
  if match then
    version = match[1]
    util.update_map(result, dataset.get('GSA'))
    util.update_version(result, version)
    return true
  end

  local match, err = ngx.re.match(ua, [[Version/([.0-9]+)]], "o")
  if match then
    version = match[1]
  end
  util.update_map(result, dataset.get('Safari'))
  util.update_version(result, version)
  return true;
end


function _M.challenge_firefox(ua, result)
  if not string.find(ua, 'Firefox/', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[Firefox/([.0-9]+)]], "o")
  if match then
    version = match[1]
  end

  util.update_map(result, dataset.get('Firefox'))
  util.update_version(result, version)
  return true
end


function _M.challenge_yandexbrowser(ua, result)
  if not string.find(ua, 'YaBrowser/', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[YaBrowser/(\d+\.\d+\.\d+\.\d+)]], "o")
  if match then
    version = match[1]
  end

  util.update_map(result, dataset.get('YaBrowser'))
  util.update_version(result, version)
  return true
end


function _M.challenge_opera(ua, result)
  if not string.find(ua, 'Opera', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[Version/([.0-9]+)]], "o")
  if match then
    version = match[1]
  else
    local match, err = ngx.re.match(ua, [[Opera[/ ]([.0-9]+)]], "o")
    if match then
      version = match[1]
    end
  end

  util.update_map(result, dataset.get('Opera'))
  util.update_version(result, version)
  return true;
end

function _M.challenge_webview(ua, result)
  local version = dataset.VALUE_UNKNOWN

  if string.find(ua, 'Chrome', 1, true) and string.find(ua, 'wv', 1, true) then
    local match, err = ngx.re.match(ua, [[Version/([.0-9]+)]], "o")
    if match then
      version = match[1]
    end
    util.update_map(result, dataset.get('Webview'))
    util.update_version(result, version)
    return true
  end

  local match, err = ngx.re.match(ua, [[iP(?:hone;|ad;|od) (.*)like Mac OS X]], "o")
  if match then
    if string.find(ua, 'Safari/', 1, true) then
      return false
    end

    local match, err = ngx.re.match(ua, [[Version/([.0-9]+)]], "o")
    if match then
      version = match[1]
    end
    util.update_map(result, dataset.get('Webview'))
    util.update_version(result, version)
    return true
  end

  return false
end

function _M.challenge_sleipnir(ua, result)
  if not string.find(ua, 'Sleipnir/', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[Sleipnir/([.0-9]+)]], "o")
  if match then
    version = match[1]
  end
  util.update_map(result, dataset.get('Sleipnir'))
  util.update_version(result, version)

  -- [[
 --   Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
 --   Sleipnir is IE component browser, so for Windows only.
 -- ]]

  local win = dataset.get('Win')
  util.update_category(result, win[dataset.KEY_CATEGORY])
  util.update_os(result, win[dataset.KEY_NAME])

  return true
end

function _M.challenge_vivaldi(ua, result)
  if not string.find(ua, 'Vivaldi/', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[Vivaldi/([.0-9]+)]], "o")
  if match then
    version = match[1]
  end
  util.update_map(result, dataset.get('Vivaldi'))
  util.update_version(result, version)

  return true
end

function _M.challenge_samsung(ua, result)
  if not string.find(ua, 'SamsungBrowser/', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN
  local match, err = ngx.re.match(ua, [[SamsungBrowser/([.0-9]+)]], "o")
  if match then
    version = match[1]
  end
  util.update_map(result, dataset.get('SamsungBrowser'))
  util.update_version(result, version)

  return true
end

return _M
