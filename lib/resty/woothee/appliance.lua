local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_playstation(ua, result)
  local data, os_version, match, err = nil

  if string.find(ua, 'PSP (PlayStation Portable);', 1, true) then
    data = dataset.get('PSP')
    match, err = ngx.re.match(ua, [[PSP \(PlayStation Portable\); ([.0-9]+)\)]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'PlayStation Vita', 1, true) then
    data = dataset.get('PSVita')
    match, err = ngx.re.match(ua, [[PlayStation Vita ([.0-9]+)\)]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'PLAYSTATION 3 ', 1, true) or string.find(ua, 'PLAYSTATION 3;', 1, true) then
    data = dataset.get('PS3')
    match, err = ngx.re.match(ua, [[PLAYSTATION 3;? ([.0-9]+)\)]], "o")
    if match then
      os_version = match[1]
    end
  elseif string.find(ua, 'PlayStation 4 ', 1, true) then
    data = dataset.get('PS4')
    match, err = ngx.re.match(ua, [[PlayStation 4 ([.0-9]+)\)]], "o")
    if match then
      os_version = match[1]
    end
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  if os_version then
    util.update_os_version(result, os_version);
  end
  return true
end

function _M.challenge_nintendo(ua, result)
  local data = nil

  if string.find(ua, 'Nintendo 3DS;', 1, true) then
    data = dataset.get('Nintendo3DS')
  elseif string.find(ua, 'Nintendo DSi;', 1, true) then
    data = dataset.get('NintendoDSi')
  elseif string.find(ua, 'Nintendo Wii;', 1, true) then
    data = dataset.get('NintendoWii')
  elseif string.find(ua, '(Nintendo WiiU)', 1, true) then
    data = dataset.get('NintendoWiiU')
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  return true
end

function _M.challenge_digitalTV(ua, result)
  local data = nil

  if string.find(ua, 'InettvBrowser/', 1, true) then
    data = dataset.get('DigitalTV')
  end

  if not data then
    return false
  end

  util.update_map(result, data)
  return true
end

return _M
