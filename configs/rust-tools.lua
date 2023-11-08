-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
--
-- local options = {
--   server = {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--       ["rust-analyzer"] = {
--         cargo = {
--           allFeatures = true,
--         },
--         assist = {
--           importEnforceGranularity = true,
--           importPrefix = "crate",
--         },
--         checkOnSave = {
--           command = "clippy",
--         },
--         -- inlayHints = { locationLinks = false },
--         diagnostics = {
--           enable = true,
--           experimental = {
--             enable = true,
--           },
--         },
--       },
--     },
--   },
-- }


local M = {}

M.filetype = "rust"

M.dependencies = {
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
}

function M.hover_actions()
  require("rust-tools").hover_actions.hover_actions()
end

function M.config()
  local on_attach = require("plugins.configs.lspconfig").on_attach
  local capabilities = require("plugins.configs.lspconfig").capabilities

  local rt = require("rust-tools")
  rt.setup({
    tools = {
      inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = true,
      },
      hover_actions = {
        border = "none",
        auto_focus = true,
      },
    },
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })

end
return M
return options
