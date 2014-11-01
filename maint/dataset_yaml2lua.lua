require "luarocks.loader"

local lyaml = require('lyaml')
local etlua = require('etlua')

local dataset_fname = "woothee/dataset.yaml"
local write_fname   = "lib/resty/woothee/dataset.lua"

local template = etlua.compile([[
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

<% for i, dataset in ipairs(dataset_entries) do %>
local obj = {
  label='<%= dataset.label -%>',
  name='<%= dataset.name -%>',
  type='<%= dataset.type -%>'
}
<% if dataset.type == 'browser' then -%>
obj["vendor"] = '<%= dataset.vendor -%>'
<% elseif dataset.type == 'os' then -%>
obj["category"] = '<%= dataset.category -%>'
<% elseif dataset.type == 'full' then -%>
obj["vendor"] = '<%= dataset.vendor or "" -%>'
obj["category"] = '<%= dataset.category -%>'
<% if dataset.os then -%>
obj["os"] = '<%= dataset.os -%>'
<% end -%>
<% else -%>
@INVALID-TYPE@
<% end -%>
DATASET[obj.label] = obj
<% end -%>

function _M.get(label)
  return DATASET[label]
end

return _M
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
local slurp_dataset_yaml = read_file(dataset_fname)
local dataset_entries = lyaml.load(slurp_dataset_yaml)
local dataset_string = template({
  dataset_entries = dataset_entries
})
write_file(write_fname, dataset_string)
