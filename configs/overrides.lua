local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "markdown",
    "markdown_inline",
    "rust",
    "bash",
    "yaml",
    "toml",
    "rust",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- bash stuff
    "shfmt",
    "shellcheck",
    "bash-language-server",

    -- rust
    "rust-analyzer",

    -- markdown
    "marksman",
    "misspell",

    "codelldb",

    -- go stuff
    "gopls",
    "goimports",
    "gotests",

    -- "gofumpt",
    -- "glint",
    -- "go-debug-adapter",
    -- "goimports-reviser",
    -- "golangci-lint",
    -- "golangci-lint-langserver",
    -- "golines",
    -- "gotests",
    -- "gotestsum",
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
