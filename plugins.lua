local overrides = require("custom.configs.overrides")

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
    opts = overrides.mason
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
  
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   event = "VeryLazy",
  --   dependencies = "mfussenegger/nvim-dap",
  --   config = function()
  --     local dap = require("dap")
  --     local dapui = require("dapui")
  --     dapui.setup()
  --     dap.listeners.after.event_initialized["dapui_config"] = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated["dapui_config"] = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited["dapui_config"] = function()
  --       dapui.close()
  --     end
  --   end
  -- },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "williamboman/mason.nvim",
  --     "mfussenegger/nvim-dap",
  --   },
  --   opts = {
  --     handlers = {}
  --   },
  -- },
  -- {
  --   "mfussenegger/nvim-dap",
  --   config = function(_, _)
  --     require("core.utils").load_mappings("dap")
  --   end
  -- },
  -- {
  --   "dreamsofcode-io/nvim-dap-go",
  --   ft = "go",
  --   dependencies = "mfussenegger/nvim-dap",
  --   config = function(_, opts)
  --     require("dap-go").setup(opts)
  --     require("core.utils").load_mappings "dap_go"
  --   end,
  -- },

  -- GO
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
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
      require("core.utils").load_mappings("dap_go")
    end
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"rust", "toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "echasnovski/mini.comment",
    version = false,
    config = function()
      require("mini.comment").setup {
        mappings = {
          -- C-/ to comment
          comment_line = "<C-_>",
          comment = "<C-_>",
        },
        options = {
          ignore_blank_line = true,
        },
      }
    end,
  },
  {
    'echasnovski/mini.trailspace',
    version = false,
    config = function()
      require('mini.trailspace').setup()
    end
  },
  {
    "echasnovski/mini.move"
  },
  {
    "kdheepak/lazygit.nvim",
    keys={
      {"<leader>gg","<cmd>LazyGit<cr>", desc="LazyGit"},
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {}
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  -- {
  --   "dreamsofcode-io/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("chatgpt").setup {
  --       api_key_cmd = "op read --account my.1password.com op://private/OpenAI/credential --no-newline",
  --     }
  --   end,
  -- },
}

return plugins
