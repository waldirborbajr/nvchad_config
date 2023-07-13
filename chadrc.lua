---@type ChadrcConfig 
local M = {}

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  transparency = false,
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.format_on_save = true

return M
