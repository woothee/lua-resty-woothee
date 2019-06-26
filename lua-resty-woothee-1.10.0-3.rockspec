package = "lua-resty-woothee"
version = "1.10.0-3"
source = {
    url = "git://github.com/woothee/lua-resty-woothee",
    tag = "v1.10.0-3"
}
description = {
    summary = "Woothee(UA Parser) Lua-Openresty implementation",
    detailed = [[The Lua-Openresty implementation of Project Woothee, which is multi-language user-agent strings parsers.]],
    homepage = "https://github.com/toritori0318/lua-resty-woothee",
    license = "Apache License 2.0",
    maintainer = "toritori0318"
}
dependencies = {
    "lua >= 5.1"
}
build = {
    type = "builtin",
    modules = {
        ["resty.woothee"] = "lib/resty/woothee.lua",
        ["resty.woothee.appliance"] = "lib/resty/woothee/appliance.lua",
        ["resty.woothee.browser"] = "lib/resty/woothee/browser.lua",
        ["resty.woothee.crawler"] = "lib/resty/woothee/crawler.lua",
        ["resty.woothee.dataset"] = "lib/resty/woothee/dataset.lua",
        ["resty.woothee.misc"] = "lib/resty/woothee/misc.lua",
        ["resty.woothee.mobile_phone"] = "lib/resty/woothee/mobile_phone.lua",
        ["resty.woothee.os"] = "lib/resty/woothee/os.lua",
        ["resty.woothee.util"] = "lib/resty/woothee/util.lua"
    }
}
