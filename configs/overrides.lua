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

-- M.chatGPT = {
--   defaults = {
--     api_key_cmd = nil,
--     yank_register = "+",
--     edit_with_instructions = {
--       diff = false,
--       keymaps = {
--         close = "<C-c>",
--         accept = "<C-y>",
--         toggle_diff = "<C-d>",
--         toggle_settings = "<C-o>",
--         cycle_windows = "<Tab>",
--         use_output_as_input = "<C-i>",
--       },
--     },
--     chat = {
--       welcome_message = WELCOME_MESSAGE,
--       loading_text = "Loading, please wait ...",
--       question_sign = "", -- 🙂
--       answer_sign = "ﮧ", -- 🤖
--       max_line_length = 120,
--       sessions_window = {
--         border = {
--           style = "rounded",
--           text = {
--             top = " Sessions ",
--           },
--         },
--         win_options = {
--           winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--         },
--       },
--       keymaps = {
--         close = { "<C-c>" },
--         yank_last = "<C-y>",
--         yank_last_code = "<C-k>",
--         scroll_up = "<C-u>",
--         scroll_down = "<C-d>",
--         new_session = "<C-n>",
--         cycle_windows = "<Tab>",
--         cycle_modes = "<C-f>",
--         next_message = "<C-j>",
--         prev_message = "<C-k>",
--         select_session = "<Space>",
--         rename_session = "r",
--         delete_session = "d",
--         draft_message = "<C-d>",
--         edit_message = "e",
--         delete_message = "d",
--         toggle_settings = "<C-o>",
--         toggle_message_role = "<C-r>",
--         toggle_system_role_open = "<C-s>",
--         stop_generating = "<C-x>",
--       },
--     },
--     popup_layout = {
--       default = "center",
--       center = {
--         width = "80%",
--         height = "80%",
--       },
--       right = {
--         width = "30%",
--         width_settings_open = "50%",
--       },
--     },
--     popup_window = {
--       border = {
--         highlight = "FloatBorder",
--         style = "rounded",
--         text = {
--           top = " ChatGPT ",
--         },
--       },
--       win_options = {
--         wrap = true,
--         linebreak = true,
--         foldcolumn = "1",
--         winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--       },
--       buf_options = {
--         filetype = "markdown",
--       },
--     },
--     system_window = {
--       border = {
--         highlight = "FloatBorder",
--         style = "rounded",
--         text = {
--           top = " SYSTEM ",
--         },
--       },
--       win_options = {
--         wrap = true,
--         linebreak = true,
--         foldcolumn = "2",
--         winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--       },
--     },
--     popup_input = {
--       prompt = "  ",
--       border = {
--         highlight = "FloatBorder",
--         style = "rounded",
--         text = {
--           top_align = "center",
--           top = " Prompt ",
--         },
--       },
--       win_options = {
--         winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--       },
--       submit = "<C-Enter>",
--       submit_n = "<Enter>",
--       max_visible_lines = 20,
--     },
--     settings_window = {
--       border = {
--         style = "rounded",
--         text = {
--           top = " Settings ",
--         },
--       },
--       win_options = {
--         winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
--       },
--     },
--     openai_params = {
--       model = "gpt-3.5-turbo",
--       frequency_penalty = 0,
--       presence_penalty = 0,
--       max_tokens = 300,
--       temperature = 0,
--       top_p = 1,
--       n = 1,
--     },
--     openai_edit_params = {
--       model = "gpt-3.5-turbo",
--       frequency_penalty = 0,
--       presence_penalty = 0,
--       temperature = 0,
--       top_p = 1,
--       n = 1,
--     },
--     use_openai_functions_for_edits = false,
--     actions_paths = {},
--     show_quickfixes_cmd = "Trouble quickfix",
--     predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
--   },
-- }

return M
