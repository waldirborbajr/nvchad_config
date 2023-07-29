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
    -- "astro",

    "c",
    "markdown",
    "markdown_inline",
    "dockerfile",
    -- "python",
    "toml",
    "rust",

    -- GO
    "go",
    "gomod",
    "gowork",
    "gosum",

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
  playground = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = 1000,
    query = {
      "rainbow-parens",
      html = "rainbow-tags",
      javascript = "rainbow-tags-react",
      tsx = "rainbow-tags",
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
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
    -- "emmet-ls",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- go
    "golangci-lint",
    "golangci-lint-langserver",
    "goimports",
    "goimports-reviser",
    -- "gopls",
    -- "impl",
    -- "iferr",
    -- "staticcheck",
    "gomodifytags",
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
    "yaml-language-server",
    "hadolint",
  },
}

-- git support in nvimtree
-- M.nvimtree = {
--   git = {
--     enable = true,
--   },
--   renderer = {
--     highlight_git = true,
--     icons = {
--       show = {
--         git = true,
--       },
--     },
--   },
-- }

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    severity = {
      min = vim.diagnostic.severity.ERROR,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  renderer = {
    symlink_destination = false,
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}

return M
