local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = { "gopls", "golangci_lint_ls", "dockerls", "rust_analyzer", "yamlls" }

local custom_on_attach = function(client, bufnr)
  on_attach(client, bufnr)

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = on_attach,
    on_attach = custom_on_attach,
    capabilities = capabilities,
  }
end

vim.diagnostic.config {
  virtual_text = false,
  underline = true,
}

--
-- lspconfig.pyright.setup { blabla}

-- lspconfig.lua_ls.setup {
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--     },
--   },
-- }

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
}

-- YAML
lspconfig.yamlls.setup {
  capabilities = capabilities,
  -- flags = default_flags,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
      },
    },
  },
  on_attach = on_attach,
}

-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "rust" },
--   root_dir = lspconfig.util.root_pattern "Cargo.toml",
-- }

-- lspconfig.rust_analyzer.setup {
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--       -- checkOnSave = {
--       --   command = "clippy",
--       -- },
--     },
--   },
-- }
