local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   -- format & linting
    --   {
    --     "jose-elias-alvarez/null-ls.nvim",
    --     config = function()
    --       require "custom.configs.null-ls"
    --     end,
    --   },
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

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }

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

  -- Alternative to null-ls
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = overrides.formatters,
    keys = {
      -- stylua: ignore
      { '=', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
    },
    -- opts = {
    --   formatters_by_ft = {
    --     go = { "gofumpt", "goimports", "golines" },
    --
    --     -- astro = { "prettierd" },
    --     -- css = { "prettierd" },
    --     -- scss = { "prettierd" },
    --     -- javascript = { "prettierd" },
    --     -- javascriptreact = { "prettierd" },
    --     -- typescript = { "prettierd" },
    --     -- typescriptreact = { "prettierd" },
    --     -- markdown = { "prettierd" },
    --
    --     lua = { "stylua" },
    --
    --     -- sh = { "shfmt" },
    --     -- zsh = { "shfmt" },
    --   },
    --   format_on_save = { lsp_fallback = true, async = false, timeout = 500 },
    -- },
  },

  -- Format
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end,
  },

  -- Debugging
  {
    "rcarriga/nvim-dap-ui",
    -- init = function()
    --   require("core.utils").load_mappings "Dap"
    -- end,
    dependencies = {
      {
        "mfussenegger/nvim-dap",
        config = function()
          -- NOTE: Check out this for guide
          -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
          local dap = require "dap"
          vim.fn.sign_define(
            "DapBreakpoint",
            { text = "🛑", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
          )

          local dapui = require "dapui"
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end

          -- dap.listeners.before.event_terminated["dapui_config"] = function()
          --   dapui.close()
          -- end

          -- dap.listeners.before.event_exited["dapui_config"] = function()
          --   dapui.close()
          -- end

          -- NOTE: Make sure to install the needed files/exectubles through mason
          require "custom.configs.dap.go-debug-adapter"
        end,
      },
    },
    opts = overrides.dap_ui,
  },

  -- MarkdownPreview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

return plugins
