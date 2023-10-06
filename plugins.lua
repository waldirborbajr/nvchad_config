local plugins = {
  { "williamboman/mason.nvim", opts = require "custom.configs.mason" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- GO
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings "gopher"
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
  {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    --   event = "BufEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })

      vim.g.codeium_filetypes = {
        ["TelescopePrompt"] = false,
      }
    end,
  },

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

  -- Format
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end,
  },

  -- Alternative to null-ls
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    keys = {
      -- stylua: ignore
      { '=', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
    },
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports", "golines" },

        -- astro = { "prettierd" },
        -- css = { "prettierd" },
        -- scss = { "prettierd" },
        -- javascript = { "prettierd" },
        -- javascriptreact = { "prettierd" },
        -- typescript = { "prettierd" },
        -- typescriptreact = { "prettierd" },
        -- markdown = { "prettierd" },

        lua = { "stylua" },

        -- sh = { "shfmt" },
        -- zsh = { "shfmt" },
      },
      format_on_save = { lsp_fallback = true, async = false, timeout = 500 },
    },
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = require "custom.configs.treesitter",
    init = function()
      require("nvim-treesitter.install").prefer_git = true
    end,
  },

  -- Obsidian
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      "BufReadPre path/to/my-vault/**.md",
      "BufNewFile path/to/my-vault/**.md",
    },
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      dir = "~/wks/Dropbox/2ndBrain/", -- no need to call 'vim.fn.expand' here

      -- see below for full list of options 👇
    },
    -- config = function()
    --   require "custom.configs.obsidian"
    -- end,
  },

  -- Trouble
  {
    "folke/trouble.nvim",

    event = "BufEnter",

    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = require "custom.configs.trouble",
  },

  --DAP
  {
    "mfussenegger/nvim-dap",

    event = "BufEnter",

    config = function()
      require "custom.configs.dap"
    end,
  },

  {
    "rcarriga/nvim-dap-ui",

    event = "BufEnter",

    dependencies = {
      "mfussenegger/nvim-dap",
    },

    config = function()
      require("dapui").setup(require "custom.configs.dapui")
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",

    event = "BufEnter",

    dependencies = {
      "nvim-dap",
    },

    config = function()
      require("nvim-dap-virtual-text").setup(require "custom.configs.dap-virtual-text")
    end,
  },

  -- NvimTree
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
return plugins
