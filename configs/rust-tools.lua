local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate",
        },
        checkOnSave = {
          command = "clippy",
        },
        -- inlayHints = { locationLinks = false },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      },
    },
  },
}

return options
