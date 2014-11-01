# vim:set ft= ts=4 sw=4 et:

use Test::Nginx::Socket::Lua;
use Cwd qw(cwd);

repeat_each(1);

plan tests => repeat_each() * (3 * blocks());

my $pwd = cwd();

our $HttpConfig = qq{
    lua_package_path "$pwd/lib/?.lua;;";
};

$ENV{TEST_NGINX_RESOLVER} = '8.8.8.8';

no_long_string();
#no_diff();

run_tests();

__DATA__

=== TEST 1: basic
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local woothee = require "resty.woothee"
            -- crawler true
            ngx.say(woothee.is_crawler("Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"))
            -- crawler false
            ngx.say(woothee.is_crawler("Mozilla/5.0 (iPhone; CPU iPhone OS 5_0_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A405 Safari/7534.48.3"))
        ';
    }
--- request
    GET /t
--- response_body
true
false
--- no_error_log
[error]
