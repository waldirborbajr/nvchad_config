local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "bash",
    "rust",
    -- "html",
    -- "css",
    -- "javascript",
    -- "typescript",
    -- "tsx",
    -- "c",
    "markdown",
    "markdown_inline",
    "bash",
    "json",
    "yaml",
    "toml",
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      },
    },
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

    -- go stuff
    "gopls",
    "goimports",
    "gofumpt",
    "glint",
    "go-debug-adapter",
    "goimports-reviser",
    "golangci-lint",
    "golangci-lint-langserver",
    "golines",
    "gotests",
    "gotestsum",

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
  auto_reload_on_write = true,
  filters = {
    dotfiles = true,
    custom = { "node_modules" },
  },
  git = {
    enable = true,
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
  modified = {
    enable = true,
  },
  view = {
    preserve_window_proportions = true,
  },
}

M.formatters = {
  format_on_save = {
    -- These options will be passed to conform.format()
    async = false,
    timeout_ms = 2000,
    quiet = true,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofumpt", "goimports", "golines" },
    markdown = { "prettier" },
    rust = { "rustfmt" },
    toml = { "taplo" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    bash = { "shfmt" },
    -- Missing Markdownlint
    ["*"] = { "trim_whitespace", "trim_newlines" },
  },
  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
    beautysh = {
      prepend_args = { "-i", "2" },
    },
    -- dprint = {
    --   condition = function(ctx)
    --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
    --   end,
    -- },
  },
}

M.dap_ui = {
  layouts = {
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
}

M.cmp = {
  completion = {
    completeopt = "menu,menuone,noselect",
  },
  sources = {
    { name = "codeium", group_index = 2 },
    { name = "crates", group_index = 2 },
    { name = "nvim_lsp", group_index = 2 },
    { name = "luasnip", group_index = 2 },
    { name = "buffer", group_index = 2 },
    { name = "nvim_lua", group_index = 2 },
    { name = "path", group_index = 2 },
  },
  mapping = {
    ["<CR>"] = require("cmp").mapping.confirm {
      behavior = require("cmp").ConfirmBehavior.Insert,
      select = false,
    },
  },
  experimental = {
    ghost_text = true,
  },
}

return M
