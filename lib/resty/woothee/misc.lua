local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_desktop_tools(ua, result)
  local data = nil

  if string.find(ua, 'AppleSyndication/', 1, true) then
    data = dataset.get('SafariRSSReader')
  elseif string.find(ua, 'compatible; Google Desktop/', 1, true) then
    data = dataset.get('GoogleDesktop')
  elseif string.find(ua, 'Windows-RSS-Platform', 1, true) or string.find(ua, 'PLAYSTATION 3;', 1, true) then
    data = dataset.get('WindowsRSSReader')
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  return true
end


function _M.challenge_smart_phone_patterns(ua, result)
  if string.find(ua, 'CFNetwork/', 1, true) then
    local data = dataset.get('iOS');
    util.update_category(result, data[dataset.KEY_CATEGORY])
    util.update_os(result, data[dataset.KEY_NAME])
    return true
  end

  return false
end


function _M.challenge_http_library(ua, result)
  local data,version = nil

  if ngx.re.match(ua, [[^(?:Apache-HttpClient/|Jakarta Commons-HttpClient/|Java/)]], "o") or ngx.re.match(ua, [[[- ]HttpClient(/|$)]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'Java'
  elseif string.find(ua, 'Java(TM) 2 Runtime Environment,', 1, true) then
    data = dataset.get('HTTPLibrary')
    version = 'Java'
  elseif ngx.re.match(ua, [[^Wget]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'wget'
  elseif ngx.re.match(ua, [[^(?:libwww-perl|WWW-Mechanize|LWP::Simple|LWP |lwp-trivial)]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'perl'
  elseif ngx.re.match(ua, [[^(?:Ruby|feedzirra|Typhoeus)]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'ruby'
  elseif ngx.re.match(ua, [[^(?:Python-urllib\/|Twisted )]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'python'
  elseif ngx.re.match(ua, [[^(?:PHP|WordPress|CakePHP|PukiWiki|PECL::HTTP)(?:/| |$)]], "o") or ngx.re.match(ua, [[(?:PEAR |)HTTP_Request(?: class|2)]], "o") then
    data = dataset.get('HTTPLibrary')
    version = 'php'
  elseif string.find(ua, 'PEAR HTTP_Request class;', 1, true) then
    data = dataset.get('HTTPLibrary')
    version = 'php'
  elseif string.find(ua, 'curl/', 1, true) then
    data = dataset.get('HTTPLibrary')
    version = 'curl'
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  util.update_version(result, version)
  return true
end


function _M.challenge_maybe_rss_reader(ua, result)
  local data = nil

  if ngx.re.match(ua, [[rss(?:reader|bar|[-_ /;()]|[ +]*/)]], "io") or ngx.re.match(ua, [[headline-reader]], "io") then
    data = dataset.get('VariousRSSReader')
  else
    if string.find(ua, 'cococ/', 1, true) then
      data = dataset.get('VariousRSSReader');
    end
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  return true
end

return _M
