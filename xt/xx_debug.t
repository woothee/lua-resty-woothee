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

=== TEST 1: [debug]
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local woothee = require "resty.woothee"
            local set_name = "Crawler"
            local target = "Mozilla/5.0 (Windows NT xxxxxxxxxxxxxx....)"
            -- local target = "Girls/2.0 (livedoor Co.,Ltd.; Peachy 2.1; iPhone; RSS Version 2.0; +http://girls.livedoor.com/)"
            local r = woothee.parse(target)
            local inspect = require("inspect")
            ngx.say("browser=" .. target)
            ngx.say(inspect(r))
        ';
    }
--- request
    GET /t
--- response_body
debug
--- no_error_log
[error]
