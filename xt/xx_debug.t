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
            local target = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022"
            -- local target = "Girls/2.0 (livedoor Co.,Ltd.; Peachy 2.1; iPhone; RSS Version 2.0; +http://girls.livedoor.com/)"
            local r = woothee.parse(target)
            local inspect = require("inspect")
            ngx.say(inspect(r))
        ';
    }
--- request
    GET /t
--- response_body
debug
--- no_error_log
[error]
