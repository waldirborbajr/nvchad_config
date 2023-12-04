local key = vim.keymap
local MASON_PATH = vim.fn.expand "$HOME/.local/share/nvim/mason/packages"

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
    -- "gofumpt",
    -- "glint",
    -- "go-debug-adapter",
    -- "goimports-reviser",
    -- "golangci-lint",
    -- "golangci-lint-langserver",
    -- "golines",
    -- "gotests",
    -- "gotestsum",

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
    show_on_dirs = true,
    show_on_open_dirs = true,
    timeout = 200,
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
    centralize_selection = true,
    debounce_delay = 15,
    float = {
      enable = true,
      open_win_config = function()
        local WIDTH_RATIO = 0.5
        local HEIGHT_RATIO = 0.8
        local screen_w = vim.opt.columns:get()
        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
        local window_w = screen_w * WIDTH_RATIO
        local window_h = screen_h * HEIGHT_RATIO
        local window_w_int = math.floor(window_w)
        local window_h_int = math.floor(window_h)
        local center_x = (screen_w - window_w) / 2
        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
        return {
          border = "rounded",
          relative = "editor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      end,
      quit_on_focus_loss = true,
    },
  },
}

M.conform = {
  format_on_save = {
    -- These options will be passed to conform.format()
    async = false,
    timeout_ms = 2000,
    quiet = true,
    lsp_fallback = true,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt", "gofumpt", "goimports", "golines" },
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

local rust_extension_path = MASON_PATH .. "/codelldb/extension"
local codelldb_path = rust_extension_path .. "/adapter/codelldb"
local liblldb_path = rust_extension_path .. "/lldb/lib/liblldb.dylib"

-- rust tools
M.rusttools = {
  server = {
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        -- enable clippy on save
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
    on_attach = function(client, bufnr)
      require("plugins.configs.lspconfig").on_attach(client, bufnr)

      local rt = require "rust-tools"

      -- general settings
      rt.inlay_hints.enable()

      -- Rust mappings
      key.set("n", "<leader>rc", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Hover actions" })
      key.set("n", "<leader>rr", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "Code action group" })
      key.set("n", "<leader>ro", rt.open_cargo_toml.open_cargo_toml, { desc = "Open Cargo.toml" })

      -- refresh codelens on TextChanged and InsertLeave as well
      vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end,
    capabilities = require("plugins.configs.lspconfig").capabilities,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
  },
  inlay_hints = {
    auto = true,
    show_parameter_hints = false,
    parameter_hints_prefix = "",
    other_hints_prefix = "",
  },
  dap = {
    adapter = {
      type = "server",
      port = "${port}",
      host = "127.0.0.1",
      executable = {
        command = codelldb_path,
        args = { "--liblldb", liblldb_path, "--port", "${port}" },
      },
    },
  },
}

return M
