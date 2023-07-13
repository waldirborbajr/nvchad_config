---@type ChadrcConfig 
local M = {}

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "mocha" },

  transparency = false,
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.format_on_save = 1 

return M
