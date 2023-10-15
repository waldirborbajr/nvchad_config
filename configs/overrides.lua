local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "go",
    -- "html",
    -- "css",
    -- "javascript",
    -- "typescript",
    -- "tsx",
    -- "c",
    "markdown",
    "markdown_inline",
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

    "gopls",

    -- web dev stuff
    -- "css-lsp",
    -- "html-lsp",
    -- "typescript-language-server",
    -- "deno",
    -- "prettier",

    -- c/cpp stuff
    -- "clangd",
    -- "clang-format",
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

M.formatters = {
  format_on_save = {
    -- These options will be passed to conform.format()
    async = true,
    quiet = true,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt" },
  },
}

return M
