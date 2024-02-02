---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "onedark",
  theme_toggle = { "onedark", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

vim.g.rustaceanvim = {
  tools = {},
  server = {
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    settings = {
      ["rust-analyzer"] = {},
    },
  },
  dap = {},
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
