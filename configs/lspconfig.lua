local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  --
  lsp_document_formatting = true,
  -- null_ls_document_formatting_disable = true,
  max_line_len = 300,
  lsp_inlay_hints = {
    enable = true,
    only_current_line = true,
    other_hints_prefix = "• ",
  },
  diagnostic = {
    hdlr = true,
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  },
  trouble = true,
  lsp_keymaps = false,
  icons = { breakpoint = "", currentpos = "" },
  lsp_diag_virtual_text = false,
  gocoverage_sign = "│",
  -- lsp_diag_virtual_text = { space = 0, prefix = "" },
  --  cat
  -- dap_debug_gui = core.dapui,
  --
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
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

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.pylsp.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 100
        }
      }
    }
  }
}
