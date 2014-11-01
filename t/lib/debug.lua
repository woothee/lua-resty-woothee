local _M = {}
require "luarocks.loader"
local inspect = require('inspect')

function _M.output_logfile(message)
  message = inspect(message)
  local file = io.open("debug.log", "a")
  file:write(message .. "\n")
  file:close()
end

return _M
