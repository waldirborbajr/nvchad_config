local M = {}

M.cmp = {
  sources = {
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    -- "html",
    -- "css",
    -- "javascript",
    -- "typescript",
    -- "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "dockerfile",
    -- "python",
    "toml",
    "rust",
    "go",
    "gomod",
    "sql",
    "json",
    "jsonc",
    "yaml",
    "dart",
  },
  indent = {
    enable = true,
    disable = {
      "dart",
      "lua",
      --   "python"
    },
  },
  autotag = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    -- "css-lsp",
    -- "html-lsp",
    -- "typescript-language-server",
    -- "vscode-css-language-server",
    -- "vscode-html-language-server",
    -- "tailwindcss-language-server",
    -- "deno",
    -- "prettier",
    -- "eslint",

    -- c/cpp stuff
    "clangd",
    "clang-format",
    -- go
    "golangci-lint",
    "golangci-lint-langserver",
    "goimports",
    "goimports-reviser",
    "gopls",
    -- "gofumpt",
    -- "gotests",
    -- "golines",

    -- rust & GO stuff
    "rust-analyzer",
    "rustfmt",

    -- toml
    "taplo",

    "codelldb",

    -- yaml
    "yamlfmt",
    "yaml-language-server",
    "yamllint",

    -- docker
    "dockerfile-language-server",
    "hadolint",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
