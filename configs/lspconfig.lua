local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
-- local util = require "lspconfig/util"

-- Diagnostics will be kept in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = true,
})

-- if you just want default config for the servers then put them in a table
local servers = {
  "cssls",
  "clangd",
  -- "pyright",
  "bashls",
  "dockerls",
  "gopls",
  "jsonls",
  -- "ltex",
  -- "marksman",
  -- "nil_ls",
  -- "perlnavigator",
  -- "pylsp",
  -- "salt_ls",
  -- "sqlls",
  "taplo",
  -- "terraformls",
  -- "tflint",
  -- "html",
  -- "cssls",
  -- "tsserver",
  -- "emmet_ls",
  "yamlls",
  "lua_ls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
  { name = "DiagnosticSignHint", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- Html setup
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "htmldjango" },
}

-- Enable inlay hints for typescript.
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

-- Enable lua setup for plugin development.
lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "require",
        },
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
}

-- lspconfig.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--         fieldalignment = true,
--         nilness = true,
--         -- shadow = true,
--         unusedwrite = true,
--         useany = true,
--       },
--     },
--   },
-- }
lspconfig.gopls.setup {
  on_attach = on_attach,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  capabilities = capabilities,
  settings = {
    gopls = {
      buildFlags = { "-tags=wireinject" },
      usePlaceholders = true,
      analyses = {
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusewrites = true,
      },
      staticcheck = true,
      codelenses = {
        references = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        generate = true,
      },
      gofumpt = true,
    },
  },
}

-- lspconfig.rust_analyzer.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "rust" },
--   root_dir = util.root_pattern "Cargo.toml",
--   settings = {
--     ["rust_analyzer"] = {
--       cargo = {
--         allFeatures = true,
--       },
--     },
--   },
-- }

-- lspconfig.eslint.setup {
--   on_attach = on_attach,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--     "vue",
--     "astro",
--   },
--   cmd = { "vscode-eslint-language-server", "--stdio" },
--   handlers = {
--     ["eslint/confirmESLintExecution"] = function(_, result)
--       if not result then
--         return
--       end
--       return 4 -- approved
--     end,
--
--     ["eslint/noLibrary"] = function()
--       vim.notify("[lspconfig] Unable to find ESLint library.", vim.log.levels.WARN)
--       return {}
--     end,
--
--     ["eslint/openDoc"] = function(_, result)
--       if not result then
--         return
--       end
--       local sysname = vim.loop.os_uname().sysname
--       if sysname:match "Windows_NT" then
--         os.execute(string.format("start %q", result.url))
--       elseif sysname:match "Linux" then
--         os.execute(string.format("xdg-open %q", result.url))
--       else
--         os.execute(string.format("open %q", result.url))
--       end
--       return {}
--     end,
--
--     ["eslint/probeFailed"] = function()
--       vim.notify("[lspconfig] ESLint probe failed.", vim.log.levels.WARN)
--       return {}
--     end,
--   },
--   root_dir = require("lspconfig").util.root_pattern(
--     ".eslintrc",
--     ".eslintrc.js",
--     ".eslintrc.cjs",
--     ".eslintrc.yaml",
--     ".eslintrc.yml",
--     ".eslintrc.json",
--     -- Disabled to prevent "No ESLint configuration found" exceptions
--     "package.json"
--   ),
--   settings = {
--     codeAction = {
--       disableRuleComment = {
--         enable = true,
--         location = "separateLine",
--       },
--       showDocumentation = {
--         enable = true,
--       },
--     },
--     codeActionOnSave = {
--       enable = false,
--       mode = "all",
--     },
--     format = true,
--     nodePath = "",
--     onIgnoredFiles = "off",
--     packageManager = "npm",
--     quiet = false,
--     rulesCustomizations = {},
--     run = "onType",
--     useESLintClass = false,
--     validate = "on",
--     workingDirectory = {
--       mode = "location",
--     },
--   },
-- }
