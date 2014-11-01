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

=== TEST 1: contains constants
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local dataset = require "resty.woothee.dataset"
            ngx.say(dataset.ATTRIBUTE_NAME)
        ';
    }
--- request
    GET /t
--- response_body
name
--- no_error_log
[error]

=== TEST 2: contains list of attributes
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local dataset = require "resty.woothee.dataset"
            local compare_list = {
              dataset.ATTRIBUTE_NAME, dataset.ATTRIBUTE_CATEGORY, dataset.ATTRIBUTE_OS,
              dataset.ATTRIBUTE_VENDOR, dataset.ATTRIBUTE_VERSION, dataset.ATTRIBUTE_OS_VERSION
            }
            for i, cattr in ipairs(compare_list) do
              for i, dattr in ipairs(dataset.ATTRIBUTE_LIST) do
                if cattr and dattr and cattr == dattr then
                  ngx.say(cattr)
                  break
                end
              end
            end
        ';
    }
--- request
    GET /t
--- response_body
name
category
os
vendor
version
os_version
--- no_error_log
[error]

=== TEST 3: contains list of categories
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local dataset = require "resty.woothee.dataset"
            local compare_list = {
              dataset.CATEGORY_PC, dataset.CATEGORY_SMARTPHONE, dataset.CATEGORY_MOBILEPHONE,
              dataset.CATEGORY_CRAWLER, dataset.CATEGORY_APPLIANCE, dataset.CATEGORY_MISC,
              dataset.VALUE_UNKNOWN
            }
            for i, cattr in ipairs(compare_list) do
              for i, dattr in ipairs(dataset.CATEGORY_LIST) do
                if cattr and dattr and cattr == dattr then
                  ngx.say(cattr)
                  break
                end
              end
            end
        ';
    }
--- request
    GET /t
--- response_body
pc
smartphone
mobilephone
crawler
appliance
misc
UNKNOWN
--- no_error_log
[error]

=== TEST 4: contains certain dataset
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local dataset = require "resty.woothee.dataset"
            ngx.say("Googlebot = " .. dataset.get("GoogleBot").name)
        ';
    }
--- request
    GET /t
--- response_body
Googlebot = Googlebot
--- no_error_log
[error]
