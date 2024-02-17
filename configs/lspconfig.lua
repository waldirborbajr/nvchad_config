local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = { "pyright" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  lsp_document_formatting = true,
  -- null_ls_document_formatting_disable = true,
  max_line_len = 300,
  lsp_inlay_hints = {
    enable = true,
    only_current_line = true,
    other_hints_prefix = "• ",
  },
  trouble = true,
  lsp_keymaps = false,
  icons = { breakpoint = "", currentpos = "" },
  lsp_diag_virtual_text = false,
  gocoverage_sign = "│",
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
