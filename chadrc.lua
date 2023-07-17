---@type ChadrcConfig 
local M = {}

M.ui = {
  theme_toggle = { "onenord", "onenord_latte" },
  theme = "onenord",
  transparency = false,
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
