local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    -- format & lintingplus
    -- {plus
    --   "jose-elias-alvarez/null-ls.nvim",plus
    --   config = function()
    --     require "custom.configs.null-ls"
    --   end,
    -- },
    -- },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  --

  -- {
  --   "NvChad/nvcommunity",
  --   -- { import = "nvcommunity.completion.copilot" },
  --   { import = "nvcommunity.git.lazygit" },
  --   { import = "nvcommunity.diagnostics.trouble" },
  --
  --   { "lazygit", keys = {
  --     { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  --   } },
  -- },

  -- GO
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- "leoluz/nvim-dap-go",
    },
    -- config = function(_, opts)
    --   require("gopher").setup(opts)
    -- end,
    config = function()
      local gopher = require "gopher"
      gopher.setup {
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
        },
        goimport = "gopls",
        gofmt = "gopls",
      }
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      {
        "ray-x/guihua.lua",
        build = "cd lua/fzy && make",
      },
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- AI Autocomplete
  -- {
  --   "Exafunction/codeium.vim",
  --   cmd = "Codeium",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   -- event = "BufEnter",
  --   event = "VeryLazy",
  --   config = function()
  --     -- Change '<C-g>' here to any keycode you like.
  --     vim.keymap.set("i", "<C-g>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-;>", function()
  --       return vim.fn["codeium#CycleCompletions"](1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-,>", function()
  --       return vim.fn["codeium#CycleCompletions"](-1)
  --     end, { expr = true })
  --     vim.keymap.set("i", "<c-x>", function()
  --       return vim.fn["codeium#Clear"]()
  --     end, { expr = true })
  --
  --     vim.g.codeium_filetypes = {
  --       ["TelescopePrompt"] = false,
  --     }
  --   end,
  -- },
  --
  -- Git
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle", "TodoTrouble" },
    opts = {},
    keys = {
      { "<leader>t", "<CMD>TroubleToggle<CR>", "Toggle diagnostics" },
      { "<leader>td", "<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>", "Todo/Fix/Fixme" },
    },
  },

  -- Alternative to null-ls
  {
    "stevearc/conform.nvim",
    -- event = "VeryLazy",
    event = { "BufWritePre" },
    opts = overrides.conform,
    -- keys = {
    --   -- stylua: ignore
    --   { 'C-/', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
    -- },
  },

  -- Format
  -- {
  --   "mhartington/formatter.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return require "custom.configs.formatter"
  --   end,
  -- },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("core.utils").load_mappings "dap"
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      -- require("core.utils").load_mappings "dap_go"
    end,
  },
  -- {
  --   "mfussenegger/nvim-dap-python",
  --   ft = "python",
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --     "rcarriga/nvim-dap-ui",
  --   },
  --   config = function(_, opts)
  --     local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  --     require("dap-python").setup(path)
  --     require("core.utils").load_mappings "dap_python"
  --   end,
  -- },

  -- MarkdownPreview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Rust
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = overrides.rusttools,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "toml" },
    config = function(_, opts)
      require("crates").setup {
        popup = {
          autofocus = true,
          border = "single",
        },
      }
      -- local crates = require "crates"
      require("crates").setup(opts)
      require("crates").show()
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
      -- crates.show()
      require("core.utils").load_mappings "crates"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rust_recommended_style = false
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,

    -- opts = function()
    --   local M = require "plugins.configs.cmp"
    --   M.completion.completeopt = "menu,menuone,noselect"
    --   M.mapping["<CR>"] = cmp.mapping.confirm {
    --     behavior = cmp.ConfirmBehavior.Insert,
    --     select = false,
    --   }
    --   table.insert(M.sources, { name = "crates" })
    --   return M
    -- end,

    dependencies = {
      {
        "saecki/crates.nvim",
        tag = "v0.4.0",
        opts = {},
      },
      {
        "Exafunction/codeium.nvim",
        opts = {},
      },
      -- "Exafunction/codeium.vim",
      -- {
      --   -- snippet plugin
      --   "L3MON4D3/LuaSnip",
      --   config = function(_, opts)
      --     -- load default luasnip config
      --     require("plugins.configs.others").luasnip(opts)
      --
      --     local luasnip = require "luasnip"
      --     luasnip.filetype_extend("javascriptreact", { "html" })
      --     luasnip.filetype_extend("typescriptreact", { "html" })
      --     require("luasnip/loaders/from_vscode").lazy_load()
      --   end,
      -- },
    },

    -- ChatGPT
    -- {
    --   "jackMort/ChatGPT.nvim",
    --   opts = overrides.chatGPT,
    --   event = "VeryLazy",
    --   config = function()
    --     require("chatgpt").setup()
    --   end,
    --   dependencies = {
    --     "MunifTanjim/nui.nvim",
    --     "nvim-lua/plenary.nvim",
    --     "nvim-telescope/telescope.nvim",
    --   },
    -- },
  },
}

return plugins
