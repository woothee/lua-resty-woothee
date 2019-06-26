local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_docomo(ua, result)
  if not string.find(ua, 'DoCoMo', 1, true) and not string.find(ua, ';FOMA;', 1, true) then
    return false;
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[DoCoMo/[.0-9]+[ /]([^- /;()"']+)]], "o")
  if match then
    version = match[1];
  else
    match, err = ngx.re.match(ua, [[\(([^;)]+);FOMA;]], "o")
    if match then
      version = match[1];
    end
  end

  util.update_map(result, dataset.get('docomo'))
  util.update_version(result, version)
  return true;
end


function _M.challenge_au(ua, result)
  if not string.find(ua, 'KDDI-', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[KDDI-([^- /;()"']+)]], "o")
  if match then
    version = match[1]
  end

  util.update_map(result, dataset.get('au'))
  util.update_version(result, version)
  return true
end


function _M.challenge_softbank(ua, result)
  if not string.find(ua, 'SoftBank', 1, true) and not string.find(ua, 'Vodafone', 1, true) and not string.find(ua, 'J-PHONE', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[(?:SoftBank|Vodafone|J-PHONE)/[.0-9]+/([^ /;()]+)]], "o")
  if match then
    version = match[1]
  end

  util.update_map(result, dataset.get('SoftBank'))
  util.update_version(result, version)
  return true
end


function _M.challenge_willcom(ua, result)
  if not string.find(ua, 'WILLCOM', 1, true) and not string.find(ua, 'DDIPOCKET', 1, true) then
    return false
  end

  local version = dataset.VALUE_UNKNOWN;
  local match, err = ngx.re.match(ua, [[(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)]], "o")
  if match then
    version = match[1]
  end

  util.update_map(result, dataset.get('willcom'))
  util.update_version(result, version)
  return true
end

function _M.challenge_misc(ua, result)
  if string.find(ua, 'jig browser', 1, true) then
    util.update_map(result, dataset.get('jig'))
    local match, err = ngx.re.match(ua, [[jig browser[^;]+; ([^);]+)]], "o")
    if match then
      util.update_version(result, match[1])
    end
    return true
  end

  if string.find(ua, 'emobile/', 1, true) or string.find(ua, 'OpenBrowser', 1, true) or string.find(ua, 'Browser/Obigo-Browser', 1, true) then
    util.update_map(result, dataset.get('emobile'))
    return true
  end

  if string.find(ua, 'SymbianOS', 1, true) then
    util.update_map(result, dataset.get('SymbianOS'))
    return true
  end

  if string.find(ua, 'Hatena-Mobile-Gateway/', 1, true) then
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'Hatena')
    return true
  end

  if string.find(ua, 'livedoor-Mobile-Gateway/', 1, true) then
    util.update_map(result, dataset.get('MobileTranscoder'))
    util.update_version(result, 'livedoor')
    return true
  end

  return false
end

return _M
