# Woothee lua resty

The Lua-Openresty implementation of Project Woothee, which is multi-language user-agent strings parsers.

https://github.com/woothee/woothee

## Synopsis

#### Basic Usage

```lua
lua_package_path "/path/to/woothee-lua-resty/lib/?.lua;;";

server {
    location /test {
        content_by_lua '
            local woothee = require "resty.woothee"

            -- parse
            local r = woothee.parse(ngx.var.http_user_agent)
            --  => {'name': 'xxx', 'category': 'xxx', 'os': 'xxx', 'version': 'xxx', 'vendor': 'xxx'}

            -- crawler?
            local crawler = woothee.is_crawler("Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)")
            --  => true

            ngx.header.content_type = 'text/plain'
            ngx.say(r.name)
        ';
    }
}
```

#### Include Nginx Log

```lua
lua_package_path "/path/to/woothee-lua-resty/lib/?.lua;;";

log_format woothee_format
                  '$remote_addr - $remote_user [$time_local] '
                  '"$request" $status $body_bytes_sent '
                  '"$http_referer" "$http_user_agent" '
                  '"$x_wt_name" "$x_wt_category" "$x_wt_os" "$x_wt_version" "$x_wt_vendor" "$x_wt_os_version"'
                  ;

server {

    access_log /var/log/nginx/nginx-access-woothee.log woothee_format;

    # set nginx valiables
    set $x_wt_name       '-';
    set $x_wt_category   '-';
    set $x_wt_os         '-';
    set $x_wt_version    '-';
    set $x_wt_vendor     '-';
    set $x_wt_os_version '-';

    location /test {
        content_by_lua '
            local woothee = require "resty.woothee"
            local r = woothee.parse(ngx.var.http_user_agent)
            -- set nginx valiables
            ngx.var.x_wt_name       = r.name
            ngx.var.x_wt_category   = r.category
            ngx.var.x_wt_os         = r.os
            ngx.var.x_wt_version    = r.version
            ngx.var.x_wt_vendor     = r.vendor
            ngx.var.x_wt_os_version = r.os_version

            ngx.header.content_type = "text/plain"
            ngx.say(r.name)
        ';
    }
}
```

## For Developer

#### setup

```
brew install lua luarocks

luarocks install etlua
luarocks install inspect
luarocks install lyaml
```

#### run test

```
make all
```

* * * * *

## Authors

* TSUYOSHI TORII (toritori0318)

## License

Copyright 2014- TSUYOSHI TORII (toritori0318)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
