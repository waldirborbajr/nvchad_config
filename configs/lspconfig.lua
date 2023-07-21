local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local util = require "lspconfig/util"

-- local eslint = require("custom.eslint")

-- if you just want default config for the servers then put them in a table
-- local servers = { "html", "cssls", "tsserver", "clangd" }
local servers = { "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}

--lspconfig for tailwindcss
-- lspconfig.tailwindcss.setup({})
--
-- lspconfig.volar.setup({})
--
-- lspconfig.eslint.setup({
-- 	cmd = { "vscode-eslint-language-server", "--stdio" },
-- })

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        fieldalignment = true,
        nilness = true,
        -- shadow = true,
        unusedwrite = true,
        useany = true,
      },
    },
  },
}

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust_analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
})
