---@type ChadrcConfig
local M = {}

M.ui = {
  -- statusline = {
  --     theme = 'minimal',
  -- },
  -- transparency = false,
  -- nvdash = {
  --     load_on_startup = true,
  --     buttons = {
  --         { '  Find File', 'Spc f f', 'Telescope find_files' },
  --         { '󰈚  Recent Files', 'Spc f o', 'Telescope oldfiles' },
  --         { '󰈭  Find Word', 'Spc f w', 'Telescope live_grep' },
  --         { '  Bookmarks', 'Spc m a', 'Telescope marks' },
  --         { '  Themes', 'Spc t h', 'Telescope themes' },
  --         { '  Mappings', 'Spc c h', 'NvCheatsheet' },
  --     },
  -- },
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "catppuccin-frappe" },

  -- hl_override = highlights.override,
  -- hl_add = highlights.add,
}
M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
