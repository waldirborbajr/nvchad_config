local overrides = require "custom.configs.overrides"
local load_mappings = require("core.utils").load_mappings

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
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

  -- Add completion to DAP buffers
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
    dependencies = {
      -- "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "f3fora/cmp-spell",
      -- "hrsh7th/cmp-vsnip",
      "delphinus/cmp-ctags",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      -- "hrsh7th/cmp-copilot",
      "ray-x/cmp-treesitter",
      {
        "hrsh7th/cmp-cmdline",
        event = "CmdLineEnter",
      },
    },
  },
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = {
  --     enabled = function()
  --       return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  --     end,
  --   },
  -- },

  -- Inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
      require("lsp-inlayhints").setup()
    end,
  },

  -- Rust tools
  {
    -- more intelligent rust lsp with other tools
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  -- {
  --   "saecki/crates.nvim",
  --   ft = { "rust", "toml" },
  --   config = function(_, opts)
  --     local crates = require "crates"
  --     crates.setup(opts)
  --     require("cmp").setup.buffer {
  --       sources = { { name = "crates" } },
  --     }
  --     crates.show()
  --     require("core.utils").load_mappings "crates"
  --   end,
  -- },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- Flutter tools
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require "custom.configs.flutter-tools"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "htmldjango",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- Debugging adapter protocol
  -- dapui
  {
    "rcarriga/nvim-dap-ui",
    opts = require "custom.configs.dapui",
  },
  -- dap
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      {
        "theHamsta/nvim-dap-virtual-text",
        config = true,
      },
    },
    config = function()
      require "custom.configs.dap"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "nvim-lspconfig" },
    event = "VeryLazy",
  },

  -- { "nvim-telescope/telescope-dap.nvim" },

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
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings "dap_go"
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
      -- require("go").setup()
      require "custom.configs.go"
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

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
    "zbirenbaum/copilot.lua",
    config = function()
      vim.schedule(function()
        require("copilot").setup {
          suggestion = { enabled = false },
          panel = { enabled = false },
          filetypes = {
            gitcommit = true,
            markdown = true,
            nix = true,
            yaml = true,
          },
        }
      end)
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    config = function()
      require("copilot_cmp").setup()
    end,
    dependencies = {
      "zbirenbaum/copilot.lua",
    },
  },

  -- indentscope
  -- {
  --   "echasnovski/mini.indentscope",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {
  --     -- symbol = "▏",
  --     symbol = "│",
  --     options = { try_as_border = true },
  --   },
  --   init = function()
  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  --       callback = function()
  --         vim.b.miniindentscope_disable = true
  --       end,
  --     })
  --   end,
  --   config = function(_, opts)
  --     require("mini.indentscope").setup(opts)
  --   end,
  -- },
}

return plugins
