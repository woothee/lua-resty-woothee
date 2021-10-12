local _M = { }

local util = require('resty.woothee.util')
local dataset = require('resty.woothee.dataset')

function _M.challenge_google(ua, result)
  if not string.find(ua, 'Google', 1, true) then
    return false
  end

  if string.find(ua, 'compatible; Googlebot', 1, true) then
    if string.find(ua, 'compatible; Googlebot-Mobile', 1, true) then
      util.update_map(result, dataset.get('GoogleBotMobile'))
      return true
    else
      util.update_map(result, dataset.get('GoogleBot'))
      return true
    end
  end

  if string.find(ua, 'compatible; AdsBot-Google-Mobile;', 1, true) then
    util.update_map(result, dataset.get('AdsBotGoogleMobile'))
    return true
  end

  if ngx.re.match(ua, [[^AdsBot-Google]], "o") then
    util.update_map(result, dataset.get('AdsBotGoogle'))
    return true
  end

  if string.find(ua, 'Googlebot-Image/', 1, true) then
    util.update_map(result, dataset.get('GoogleBot'))
    return true
  end

  if string.find(ua, 'Mediapartners-Google', 1, true) then
    if string.find(ua, 'compatible; Mediapartners-Google', 1, true) or ua == 'Mediapartners-Google' then
      util.update_map(result, dataset.get('GoogleMediaPartners'))
      return true
    end
  end

  if string.find(ua, 'Feedfetcher-Google;', 1, true) then
    util.update_map(result, dataset.get('GoogleFeedFetcher'))
    return true
  end

  if string.find(ua, 'AppEngine-Google', 1, true) then
    util.update_map(result, dataset.get('GoogleAppEngine'))
    return true
  end

  if string.find(ua, 'Google Web Preview', 1, true) then
    util.update_map(result, dataset.get('GoogleWebPreview'))
    return true
  end

  return false
end


function _M.challenge_crawlers(ua, result)
  if string.find(ua, 'Yahoo', 1, true) or string.find(ua, 'help.yahoo.co.jp/help/jp/', 1, true)  or string.find(ua, 'listing.yahoo.co.jp/support/faq/', 1, true) then
    if string.find(ua, 'compatible; Yahoo! Slurp', 1, true) then
      util.update_map(result, dataset.get('YahooSlurp'))
      return true
    end
    if string.find(ua, 'YahooFeedSeekerJp', 1, true) or string.find(ua, 'YahooFeedSeekerBetaJp', 1, true) then
      util.update_map(result, dataset.get('YahooJP'))
      return true
    end
    if string.find(ua, 'crawler (http://listing.yahoo.co.jp/support/faq/', 1, true) or string.find(ua, 'crawler (http://help.yahoo.co.jp/help/jp/', 1, true) then
      util.update_map(result, dataset.get('YahooJP'))
      return true
    end
    if string.find(ua, 'Y!J-BRZ/YATSHA crawler', 1, true) or string.find(ua, 'Y!J-BRY/YATSH crawler', 1, true) then
      util.update_map(result, dataset.get('YahooJP'))
      return true
    end
    if string.find(ua, 'Yahoo Pipes', 1, true) then
      util.update_map(result, dataset.get('YahooPipes'))
      return true
    end
  end

  if string.find(ua, 'msnbot', 1, true) then
    util.update_map(result, dataset.get('msnbot'))
    return true
  end

  if string.find(ua, 'bingbot', 1, true) then
    if string.find(ua, 'compatible; bingbot', 1, true) then
      util.update_map(result, dataset.get('bingbot'))
      return true
    end
  end

  if string.find(ua, 'BingPreview', 1, true) then
    util.update_map(result, dataset.get('BingPreview'))
    return true
  end

  if string.find(ua, 'Baidu', 1, true) then
    if string.find(ua, 'compatible; Baiduspider', 1, true) or string.find(ua, 'Baiduspider+', 1, true) or string.find(ua, 'Baiduspider-image+', 1, true) then
      util.update_map(result, dataset.get('Baiduspider'))
      return true
    end
  end

  if string.find(ua, 'Yeti', 1, true) then
    if string.find(ua, 'http://help.naver.com/robots', 1, true) or string.find(ua, 'http://help.naver.com/support/robots.html', 1, true) or string.find(ua, 'http://naver.me/bot', 1, true) then
      util.update_map(result, dataset.get('Yeti'))
      return true
    end
  end

  if string.find(ua, 'FeedBurner/', 1, true) then
    util.update_map(result, dataset.get('FeedBurner'))
    return true
  end

  if string.find(ua, 'facebookexternalhit', 1, true) then
    util.update_map(result, dataset.get('facebook'))
    return true
  end

  if string.find(ua, 'Twitterbot/', 1, true) then
    util.update_map(result, dataset.get('twitter'))
    return true
  end

  if string.find(ua, 'ichiro', 1, true) then
    if string.find(ua, 'http://help.goo.ne.jp/door/crawler.html', 1, true) or string.find(ua, 'compatible; ichiro/mobile goo;', 1, true) then
      util.update_map(result, dataset.get('goo'))
      return true
    end
  end

  if string.find(ua, 'gooblogsearch/', 1, true) then
    util.update_map(result, dataset.get('goo'))
    return true
  end

  if string.find(ua, 'Apple-PubSub', 1, true) then
    util.update_map(result, dataset.get('ApplePubSub'))
    return true
  end

  if string.find(ua, '(www.radian6.com/crawler)', 1, true) then
    util.update_map(result, dataset.get('radian6'))
    return true
  end

  if string.find(ua, 'Genieo/', 1, true) then
    util.update_map(result, dataset.get('Genieo'))
    return true
  end

  if string.find(ua, 'labs.topsy.com/butterfly/', 1, true) then
    util.update_map(result, dataset.get('topsyButterfly'))
    return true
  end

  if string.find(ua, 'rogerbot/1.0 (http://www.seomoz.org/dp/rogerbot', 1, true) then
    util.update_map(result, dataset.get('rogerbot'))
    return true
  end

  if string.find(ua, 'compatible; AhrefsBot/', 1, true) then
    util.update_map(result, dataset.get('AhrefsBot'))
    return true
  end

  if string.find(ua, 'livedoor FeedFetcher', 1, true) or string.find(ua, 'Fastladder FeedFetcher', 1, true) then
    util.update_map(result, dataset.get('livedoorFeedFetcher'))
    return true
  end

  if string.find(ua, 'Hatena ', 1, true) then
    if string.find(ua, 'Hatena Antenna', 1, true) or string.find(ua, 'Hatena Pagetitle Agent', 1, true) or string.find(ua, 'Hatena Diary RSS', 1, true) then
      util.update_map(result, dataset.get('Hatena'))
      return true
    end
  end

  if string.find(ua, 'mixi-check', 1, true) or string.find(ua, 'mixi-crawler', 1, true)  or string.find(ua, 'mixi-news-crawler', 1, true) then
    util.update_map(result, dataset.get('mixi'))
    return true
  end

  if string.find(ua, 'Indy Library', 1, true) then
    if string.find(ua, 'compatible; Indy Library', 1, true) then
      util.update_map(result, dataset.get('IndyLibrary'))
      return true
    end
  end

  if string.find(ua, 'trendictionbot', 1, true) then
    util.update_map(result, dataset.get('trendictionbot'))
    return true
  end

  return false
end


function _M.challenge_maybe_crawler(ua, result)
  local data = nil

  if ngx.re.match(ua, [[(bot|crawler|spider)(?:[-_ ./;@()]|$)]], "io") then
    util.update_map(result, dataset.get('VariousCrawler'))
    return true
  elseif ngx.re.match(ua, [[^(?:Rome Client |UnwindFetchor/|ia_archiver |Summify |PostRank/)]], "o") or string.find(ua, 'ASP-Ranker Feed Crawler', 1, true) then
    util.update_map(result, dataset.get('VariousCrawler'))
    return true
  elseif ngx.re.match(ua, [[(feed|web) ?parser]], "io") then
    util.update_map(result, dataset.get('VariousCrawler'))
    return true
  elseif ngx.re.match(ua, [[watch ?dog]], "io") then
    util.update_map(result, dataset.get('VariousCrawler'))
    return true
  end

  return false
end

return _M
