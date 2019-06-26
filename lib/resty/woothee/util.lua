local _M = { }

local dataset = require('resty.woothee.dataset')

function _M.update_map(target, source)
  target = target or {}
  source = source or {}

  for key, _ in pairs(source) do
    if key == dataset.KEY_LABEL or key == dataset.KEY_TYPE then
      -- pass
    elseif source[key] and string.len(source[key]) > 0 then
      target[key] = source[key] or ''
    end
  end
end

function _M.update_category(target, category)
  target[dataset.ATTRIBUTE_CATEGORY] = category
end

function _M.update_version(target, version)
  target[dataset.ATTRIBUTE_VERSION] = version
end

function _M.update_os(target, os)
  target[dataset.ATTRIBUTE_OS] = os
end

function _M.update_os_version(target, version)
  target[dataset.ATTRIBUTE_OS_VERSION] = version
end

return _M
