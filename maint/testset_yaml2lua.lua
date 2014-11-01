require "luarocks.loader"

local lyaml = require('lyaml')
local etlua = require('etlua')
local dataset = require('resty.woothee.dataset');

local dataset_file = "./woothee/dataset.yaml"
local lua_file = "./lib/resty/woothee/dataset.lua"

local TESTSET_DIR = './woothee/testsets/'
local TARGETS = {
  {'crawler.yaml','Crawler'},{'crawler_google.yaml','Crawler/Google'},
  {'pc_windows.yaml', 'PC/Windows'},{'pc_misc.yaml', 'PC/Misc'},
  {'mobilephone_docomo.yaml','MobilePhone/docomo'},{'mobilephone_au.yaml','MobilePhone/au'},
  {'mobilephone_softbank.yaml','MobilePhone/softbank'},{'mobilephone_willcom.yaml','MobilePhone/willcom'},
  {'mobilephone_misc.yaml','MobilePhone/misc'},
  {'smartphone_ios.yaml','SmartPhone/ios'},{'smartphone_android.yaml','SmartPhone/android'},
  {'smartphone_misc.yaml','SmartPhone/misc'},
  {'appliance.yaml','Appliance'},
  {'pc_lowpriority.yaml','PC/LowPriority'},
  {'misc.yaml','Misc'},
  {'crawler_nonmajor.yaml','Crawler/NonMajor'}
}

local template = etlua.compile([[
=== TEST <%= no -%>: [<%= groupname -%>][<%= entry.target -%>]
--- http_config eval: $::HttpConfig
--- config
    location /t {
        content_by_lua '
            local woothee = require "resty.woothee"
            local set_name = "<%= groupname -%>"
            local target = "<%= entry.target -%>"
            local r = woothee.parse(target)
            ngx.say(string.format("%s=%s expect:%s", "name", (r["name"]=="<%= entry["name"] -%>"), "<%= entry["name"] -%>" ))
            ngx.say(string.format("%s=%s expect:%s", "category", (r["category"]=="<%= entry["category"] -%>"), "<%= entry["category"] -%>" ))
<% if entry["os"] then -%>
            ngx.say(string.format("%s=%s expect:%s", "os", (r["os"]=="<%= entry["os"] -%>"), "<%= entry["os"] -%>" ))
<% end -%>
<% if entry["os_version"] then -%>
            ngx.say(string.format("%s=%s expect:%s", "os_version", (r["os_version"]=="<%= entry["os_version"] -%>"), "<%= entry["os_version"] -%>" ))
<% end -%>
<% if entry["version"] then -%>
            ngx.say(string.format("%s=%s expect:%s", "version", (r["version"]=="<%= entry["version"] -%>"), "<%= entry["version"] -%>" ))
<% end -%>
<% if entry["vendor"] then -%>
            ngx.say(string.format("%s=%s expect:%s", "vendor", (r["vendor"]=="<%= entry["vendor"] -%>"), "<%= entry["vendor"] -%>" ))
<% end -%>
        ';
    }
--- request
    GET /t
--- response_body
name=true expect:<%= entry["name"] %>
category=true expect:<%= entry["category"] %>
<% if entry["os"] then -%>
os=true expect:<%= entry["os"] %>
<% end -%>
<% if entry["os_version"] then -%>
os_version=true expect:<%= entry["os_version"] %>
<% end -%>
<% if entry["version"] then -%>
version=true expect:<%= entry["version"] %>
<% end -%>
<% if entry["vendor"] then -%>
vendor=true expect:<%= entry["vendor"] %>
<% end -%>
--- no_error_log
[error]
]])




-- read_file
local function read_file(fname)
  local data = ''
  -- slurp dataset.yml
  local f = io.open(fname, "r")
  for line in f:lines() do
    data = data .. line .. "\n"
  end
  f:close()
  return data
end

-- write file
local function write_file(fname, data)
  local f = io.open(fname, "w")
  f:write(data)
  f:close()
end

-- main
local no = 0
for i, target in ipairs(TARGETS) do
  local entry_fname= target[1]
  local groupname = target[2]

  -- read file
  local dataset_fname = TESTSET_DIR .. entry_fname
  local slurp_dataset_yaml = read_file(dataset_fname)

  local entry_string = ''
  local testset = lyaml.load(slurp_dataset_yaml)
  for i, entry in ipairs(testset) do
    no = no + 1

    -- render
    local render_string = template({
      no = no,
      groupname = groupname,
      entry = entry,
    })

    entry_string = entry_string .. render_string
  end

  -- write file
  local sub_entry_fname = string.gsub(entry_fname, ".yaml", "")
  local wfname = "t/testfiles/" .. sub_entry_fname .. ".t"
  write_file(wfname, entry_string)
end
