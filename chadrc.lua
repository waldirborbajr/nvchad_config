---@type ChadrcConfig
  local M = {}

  M.ui = {
    theme_toggle = { "catppuccin", "catppuccin_mocha" },
    theme = "catppuccin",

    transparency = false,
  }
  M.plugins = "custom.plugins"
  M.mappings = require "custom.mappings"
 return M
