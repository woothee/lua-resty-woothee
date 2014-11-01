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
            ngx.say("OK")
        ';
    }
--- request
    GET /t
--- response_body
OK
--- no_error_log
[error]
