---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onenord",
  theme_toggle = { "onenord", "onenord_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  transparency = false,

  -- nvdash = {
  --   load_on_startup = true,
  --   buttons = {
  --     { "  Find File", "Spc f f", "Telescope find_files" },
  --     { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
  --     { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
  --     { "  Bookmarks", "Spc f m", "Telescope marks" },
  --     { "  Mappings", "Spc h c", "NvCheatsheet" },
  --   },
  -- },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
