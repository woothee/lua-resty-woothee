--------------------------------------------------
-- Auto Generate from main/dataset_yaml2lua.lua
--------------------------------------------------
local _M = { }

_M.KEY_LABEL = "label"
_M.KEY_NAME = "name"
_M.KEY_TYPE = "type"
_M.KEY_CATEGORY = "category"
_M.KEY_OS = "os"
_M.KEY_OS_VERSION = "os_version"
_M.KEY_VENDOR = "vendor"
_M.KEY_VERSION = "version"
_M.TYPE_BROWSER = "browser"
_M.TYPE_OS = "os"
_M.TYPE_FULL = "full"
_M.CATEGORY_PC = "pc"
_M.CATEGORY_SMARTPHONE = "smartphone"
_M.CATEGORY_MOBILEPHONE = "mobilephone"
_M.CATEGORY_CRAWLER = "crawler"
_M.CATEGORY_APPLIANCE = "appliance"
_M.CATEGORY_MISC = "misc"
_M.ATTRIBUTE_NAME = "name"
_M.ATTRIBUTE_CATEGORY = "category"
_M.ATTRIBUTE_OS = "os"
_M.ATTRIBUTE_OS_VERSION = "os_version"
_M.ATTRIBUTE_VENDOR = "vendor"
_M.ATTRIBUTE_VERSION = "version"
_M.VALUE_UNKNOWN = "UNKNOWN"
_M.CATEGORY_LIST = {"pc", "smartphone", "mobilephone", "crawler", "appliance", "misc", "UNKNOWN"}
_M.ATTRIBUTE_LIST = {"name", "category", "os", "vendor", "version", "os_version"}

local DATASET = {}


local obj = {
  label='MSIE',
  name='Internet Explorer',
  type='browser'
}
obj["vendor"] = 'Microsoft'
DATASET[obj.label] = obj

local obj = {
  label='Edge',
  name='Edge',
  type='browser'
}
obj["vendor"] = 'Microsoft'
DATASET[obj.label] = obj

local obj = {
  label='Chrome',
  name='Chrome',
  type='browser'
}
obj["vendor"] = 'Google'
DATASET[obj.label] = obj

local obj = {
  label='Safari',
  name='Safari',
  type='browser'
}
obj["vendor"] = 'Apple'
DATASET[obj.label] = obj

local obj = {
  label='Firefox',
  name='Firefox',
  type='browser'
}
obj["vendor"] = 'Mozilla'
DATASET[obj.label] = obj

local obj = {
  label='Opera',
  name='Opera',
  type='browser'
}
obj["vendor"] = 'Opera'
DATASET[obj.label] = obj

local obj = {
  label='Vivaldi',
  name='Vivaldi',
  type='browser'
}
obj["vendor"] = 'Vivaldi Technologies'
DATASET[obj.label] = obj

local obj = {
  label='Sleipnir',
  name='Sleipnir',
  type='browser'
}
obj["vendor"] = 'Fenrir Inc.'
DATASET[obj.label] = obj

local obj = {
  label='Webview',
  name='Webview',
  type='browser'
}
obj["vendor"] = 'OS vendor'
DATASET[obj.label] = obj

local obj = {
  label='YaBrowser',
  name='Yandex Browser',
  type='browser'
}
obj["vendor"] = 'Yandex'
DATASET[obj.label] = obj

local obj = {
  label='Win',
  name='Windows UNKNOWN Ver',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win10',
  name='Windows 10',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win8.1',
  name='Windows 8.1',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win8',
  name='Windows 8',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win7',
  name='Windows 7',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='WinVista',
  name='Windows Vista',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='WinXP',
  name='Windows XP',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win2000',
  name='Windows 2000',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='WinNT4',
  name='Windows NT 4.0',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='WinMe',
  name='Windows Me',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win98',
  name='Windows 98',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Win95',
  name='Windows 95',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='WinPhone',
  name='Windows Phone OS',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='WinCE',
  name='Windows CE',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='OSX',
  name='Mac OSX',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='MacOS',
  name='Mac OS Classic',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Linux',
  name='Linux',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='BSD',
  name='BSD',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='ChromeOS',
  name='ChromeOS',
  type='os'
}
obj["category"] = 'pc'
DATASET[obj.label] = obj

local obj = {
  label='Android',
  name='Android',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='iPhone',
  name='iPhone',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='iPad',
  name='iPad',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='iPod',
  name='iPod',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='iOS',
  name='iOS',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='FirefoxOS',
  name='Firefox OS',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='BlackBerry',
  name='BlackBerry',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='BlackBerry10',
  name='BlackBerry 10',
  type='os'
}
obj["category"] = 'smartphone'
DATASET[obj.label] = obj

local obj = {
  label='docomo',
  name='docomo',
  type='full'
}
obj["vendor"] = 'docomo'
obj["category"] = 'mobilephone'
obj["os"] = 'docomo'
DATASET[obj.label] = obj

local obj = {
  label='au',
  name='au by KDDI',
  type='full'
}
obj["vendor"] = 'au'
obj["category"] = 'mobilephone'
obj["os"] = 'au'
DATASET[obj.label] = obj

local obj = {
  label='SoftBank',
  name='SoftBank Mobile',
  type='full'
}
obj["vendor"] = 'SoftBank'
obj["category"] = 'mobilephone'
obj["os"] = 'SoftBank'
DATASET[obj.label] = obj

local obj = {
  label='willcom',
  name='WILLCOM',
  type='full'
}
obj["vendor"] = 'WILLCOM'
obj["category"] = 'mobilephone'
obj["os"] = 'WILLCOM'
DATASET[obj.label] = obj

local obj = {
  label='jig',
  name='jig browser',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'mobilephone'
obj["os"] = 'jig'
DATASET[obj.label] = obj

local obj = {
  label='emobile',
  name='emobile',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'mobilephone'
obj["os"] = 'emobile'
DATASET[obj.label] = obj

local obj = {
  label='SymbianOS',
  name='SymbianOS',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'mobilephone'
obj["os"] = 'SymbianOS'
DATASET[obj.label] = obj

local obj = {
  label='MobileTranscoder',
  name='Mobile Transcoder',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'mobilephone'
obj["os"] = 'Mobile Transcoder'
DATASET[obj.label] = obj

local obj = {
  label='Nintendo3DS',
  name='Nintendo 3DS',
  type='full'
}
obj["vendor"] = 'Nintendo'
obj["category"] = 'appliance'
obj["os"] = 'Nintendo 3DS'
DATASET[obj.label] = obj

local obj = {
  label='NintendoDSi',
  name='Nintendo DSi',
  type='full'
}
obj["vendor"] = 'Nintendo'
obj["category"] = 'appliance'
obj["os"] = 'Nintendo DSi'
DATASET[obj.label] = obj

local obj = {
  label='NintendoWii',
  name='Nintendo Wii',
  type='full'
}
obj["vendor"] = 'Nintendo'
obj["category"] = 'appliance'
obj["os"] = 'Nintendo Wii'
DATASET[obj.label] = obj

local obj = {
  label='NintendoWiiU',
  name='Nintendo Wii U',
  type='full'
}
obj["vendor"] = 'Nintendo'
obj["category"] = 'appliance'
obj["os"] = 'Nintendo Wii U'
DATASET[obj.label] = obj

local obj = {
  label='PSP',
  name='PlayStation Portable',
  type='full'
}
obj["vendor"] = 'Sony'
obj["category"] = 'appliance'
obj["os"] = 'PlayStation Portable'
DATASET[obj.label] = obj

local obj = {
  label='PSVita',
  name='PlayStation Vita',
  type='full'
}
obj["vendor"] = 'Sony'
obj["category"] = 'appliance'
obj["os"] = 'PlayStation Vita'
DATASET[obj.label] = obj

local obj = {
  label='PS3',
  name='PlayStation 3',
  type='full'
}
obj["vendor"] = 'Sony'
obj["category"] = 'appliance'
obj["os"] = 'PlayStation 3'
DATASET[obj.label] = obj

local obj = {
  label='PS4',
  name='PlayStation 4',
  type='full'
}
obj["vendor"] = 'Sony'
obj["category"] = 'appliance'
obj["os"] = 'PlayStation 4'
DATASET[obj.label] = obj

local obj = {
  label='Xbox360',
  name='Xbox 360',
  type='full'
}
obj["vendor"] = 'Microsoft'
obj["category"] = 'appliance'
obj["os"] = 'Xbox 360'
DATASET[obj.label] = obj

local obj = {
  label='XboxOne',
  name='Xbox One',
  type='full'
}
obj["vendor"] = 'Microsoft'
obj["category"] = 'appliance'
obj["os"] = 'Xbox One'
DATASET[obj.label] = obj

local obj = {
  label='DigitalTV',
  name='InternetTVBrowser',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'appliance'
obj["os"] = 'DigitalTV'
DATASET[obj.label] = obj

local obj = {
  label='SafariRSSReader',
  name='Safari RSSReader',
  type='full'
}
obj["vendor"] = 'Apple'
obj["category"] = 'misc'
DATASET[obj.label] = obj

local obj = {
  label='GoogleDesktop',
  name='Google Desktop',
  type='full'
}
obj["vendor"] = 'Google'
obj["category"] = 'misc'
DATASET[obj.label] = obj

local obj = {
  label='WindowsRSSReader',
  name='Windows RSSReader',
  type='full'
}
obj["vendor"] = 'Microsoft'
obj["category"] = 'misc'
DATASET[obj.label] = obj

local obj = {
  label='VariousRSSReader',
  name='RSSReader',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'misc'
DATASET[obj.label] = obj

local obj = {
  label='HTTPLibrary',
  name='HTTP Library',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'misc'
DATASET[obj.label] = obj

local obj = {
  label='GoogleBot',
  name='Googlebot',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='GoogleBotMobile',
  name='Googlebot Mobile',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='GoogleMediaPartners',
  name='Google Mediapartners',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='GoogleFeedFetcher',
  name='Google Feedfetcher',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='GoogleAppEngine',
  name='Google AppEngine',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='GoogleWebPreview',
  name='Google Web Preview',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='YahooSlurp',
  name='Yahoo! Slurp',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='YahooJP',
  name='Yahoo! Japan',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='YahooPipes',
  name='Yahoo! Pipes',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='Baiduspider',
  name='Baiduspider',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='msnbot',
  name='msnbot',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='bingbot',
  name='bingbot',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='BingPreview',
  name='BingPreview',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='Yeti',
  name='Naver Yeti',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='FeedBurner',
  name='Google FeedBurner',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='facebook',
  name='facebook',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='twitter',
  name='twitter',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='trendictionbot',
  name='trendiction',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='mixi',
  name='mixi',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='IndyLibrary',
  name='Indy Library',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='ApplePubSub',
  name='Apple iCloud',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='Genieo',
  name='Genieo Web Filter',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='topsyButterfly',
  name='topsy Butterfly',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='rogerbot',
  name='SeoMoz rogerbot',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='AhrefsBot',
  name='ahref AhrefsBot',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='radian6',
  name='salesforce radian6',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='Hatena',
  name='Hatena',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='goo',
  name='goo',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='livedoorFeedFetcher',
  name='livedoor FeedFetcher',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

local obj = {
  label='VariousCrawler',
  name='misc crawler',
  type='full'
}
obj["vendor"] = ''
obj["category"] = 'crawler'
DATASET[obj.label] = obj

function _M.get(label)
  return DATASET[label]
end

return _M
