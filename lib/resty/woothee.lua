local _M = { _VERSION = "1.12.0-1" }

local dataset = require('resty.woothee.dataset')
local browser = require('resty.woothee.browser')
local os = require('resty.woothee.os')
local mobile_phone = require('resty.woothee.mobile_phone')
local crawler = require('resty.woothee.crawler')
local appliance = require('resty.woothee.appliance')
local misc = require('resty.woothee.misc')
local util = require('resty.woothee.util')

local function try_crawler(useragent, result)
  if crawler.challenge_google(useragent, result) then
    return true
  end

  if crawler.challenge_crawlers(useragent, result) then
    return true
  end

  return false
end

local function try_browser(useragent, result)
  if browser.challenge_MSIE(useragent, result) then
    return true
  end

  if browser.challenge_vivaldi(useragent, result) then
    return true
  end

  if browser.challenge_yandexbrowser(useragent, result) then
    return true
  end

  if browser.challenge_samsung(useragent, result) then
    return true
  end

  if browser.challenge_safari_chrome(useragent, result) then
    return true
  end

  if browser.challenge_firefox(useragent, result) then
    return true
  end

  if browser.challenge_opera(useragent, result) then
    return true
  end

  if browser.challenge_webview(useragent, result) then
    return true
  end

  return false
end

local function try_os(useragent, result)
  if os.challenge_windows(useragent, result) then
    return true
  end

  -- OSX PC and iOS devices (strict check)
  if os.challenge_osx(useragent, result) then
    return true
  end

  -- Linux PC and Android
  if os.challenge_linux(useragent, result) then
    return true
  end

  -- all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
  if os.challenge_smart_phone(useragent, result) then
    return true
  end

  -- mobile phones like KDDI-.*
  if os.challenge_mobile_phone(useragent, result) then
    return true
  end

  -- Nintendo DSi/Wii with Opera
  if os.challenge_appliance(useragent, result) then
    return true
  end

  if os.challenge_misc(useragent, result) then
    return true
  end

  return false
end

local function try_mobile_phone(useragent, result)
  if mobile_phone.challenge_docomo(useragent, result) then
    return true
  end

  if mobile_phone.challenge_au(useragent, result) then
    return true
  end

  if mobile_phone.challenge_softbank(useragent, result) then
    return true
  end

  if mobile_phone.challenge_willcom(useragent, result) then
    return true
  end

  if mobile_phone.challenge_misc(useragent, result) then
    return true
  end

  return false
end

local function try_appliance(useragent, result)
  if appliance.challenge_playstation(useragent, result) then
    return true
  end

  if appliance.challenge_nintendo(useragent, result) then
    return true
  end

  if appliance.challenge_digitalTV(useragent, result) then
    return true
  end

  return false
end

local function try_misc(useragent, result)
  if misc.challenge_desktop_tools(useragent, result) then
    return true
  end

  return false
end

local function try_rare_cases(useragent, result)
  if misc.challenge_smart_phone_patterns(useragent, result) then
    return true
  end

  if browser.challenge_sleipnir(useragent, result) then
    return true
  end

  if misc.challenge_http_library(useragent, result) then
    return true
  end

  if misc.challenge_maybe_rss_reader(useragent, result) then
    return true
  end

  if crawler.challenge_maybe_crawler(useragent, result) then
    return true
  end

  return false
end

local function exec_parse(useragent)
  local result = {}

  if string.len(useragent) < 1 or useragent == '-' then
    return result;
  end

  if try_crawler(useragent, result) then
    return result;
  end

  if try_browser(useragent, result) then
    if try_os(useragent, result) then
      return result;
    else
      return result;
    end
  end

  if try_mobile_phone(useragent, result) then
    return result;
  end

  if try_appliance(useragent, result) then
    return result;
  end

  if try_misc(useragent, result) then
    return result;
  end

  -- browser unknown, check os only
  if try_os(useragent, result) then
    return result;
  end

  if try_rare_cases(useragent, result) then
    return result;
  end

  return result;
end

local function fill_result(result)
  if not result[dataset.ATTRIBUTE_NAME] then
    result[dataset.ATTRIBUTE_NAME] = dataset.VALUE_UNKNOWN;
  end
  if not result[dataset.ATTRIBUTE_CATEGORY] then
    result[dataset.ATTRIBUTE_CATEGORY] = dataset.VALUE_UNKNOWN;
  end
  if not result[dataset.ATTRIBUTE_OS] then
    result[dataset.ATTRIBUTE_OS] = dataset.VALUE_UNKNOWN;
  end
  if not result[dataset.ATTRIBUTE_OS_VERSION] then
    result[dataset.ATTRIBUTE_OS_VERSION] = dataset.VALUE_UNKNOWN;
  end
  if not result[dataset.ATTRIBUTE_VERSION] then
    result[dataset.ATTRIBUTE_VERSION] = dataset.VALUE_UNKNOWN;
  end
  if not result[dataset.ATTRIBUTE_VENDOR] then
    result[dataset.ATTRIBUTE_VENDOR] = dataset.VALUE_UNKNOWN;
  end
  return result
end



function _M.parse(useragent)
  useragent = useragent or ''
  return fill_result(exec_parse(useragent))
end

function _M.is_crawler(useragent)
  useragent = useragent or ''
  if try_crawler(useragent, {}) then
    return true
  end

  return false
end

return _M
