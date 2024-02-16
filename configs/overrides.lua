local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "markdown",
    "markdown_inline",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "rust",
    "bash",
    "json5",
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
    -- "taplo", --for toml lsp

    -- Python
    -- "black",
    -- "python-lsp-server",
    -- "pyright",
    -- "debugpy",

    -- markdown
    "marksman",
    "misspell",

    "codelldb",

    -- go stuff
    "gopls",
    "goimports-reviser",
    "golines",
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
