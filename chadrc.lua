---@type ChadrcConfig 
local M = {}

M.ui = {
  theme_toggle = { "catppuccin", "catppuccin_latte" },
  theme = "catppuccin",

  transparency = false,
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

M.format_on_save = 1 

return M
