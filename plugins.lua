local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    -- format & linting
    -- {
    --   "jose-elias-alvarez/null-ls.nvim",
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
  --

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
  --   "Exafunction/codeium.nvim",
  -- cmd = "Codeium",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   "hrsh7th/nvim-cmp",
  -- },
  --   event = "BufEnter",
  --   -- event = "VeryLazy",
  --   --   event = "BufEnter",
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
    event = { "BufReadPre", "BufNewFile" },
    opts = overrides.formatters,
    keys = {
      -- stylua: ignore
      { '=', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
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
    ft = "rust",
    config = function()
      require("rust-tools").setup {
        tools = {
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
          },
        },
        --
        -- all the opts to send to nvim-lspconfig
        -- these override the defaults set by rust-tools.nvim
        -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
        server = {
          on_attach = function(_, buffer)
            require("core.utils").load_mappings "lspconfig"
          end,

          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              assist = {
                importEnforceGranularity = true,
                importPrefix = "crate",
              },
              checkOnSave = {
                command = "clippy",
              },
              -- inlayHints = { locationLinks = false },
              diagnostics = {
                enable = true,
                experimental = {
                  enable = true,
                },
              },
            },
          },

          -- settings = {
          --   -- to enable rust-analyzer settings visit:
          --   -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          --   ["rust-analyzer"] = {
          --     -- enable clippy on save
          --     checkOnSave = {
          --       command = "clippy",
          --     },
          --   },
          -- },
        },
      }
    end,
  },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = require("custom.configs.rust-tools").filetype,
  --   dependencies = require("custom.configs.rust-tools").dependencies,
  --   config = require("custom.configs.rust-tools").config,
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   ft = "rust",
  --   dependencies = "neovim/nvim-lspconfig",
  --   opts = function()
  --     return require "custom.configs.rust-tools"
  --   end,
  --   config = function(_, opts)
  --     require("rust-tools").setup(opts)
  --   end,
  -- },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    ft = { "toml" },
    config = function(_, opts)
      -- local crates = require "crates"
      require("crates").setup(opts)
      require("crates").show()
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
      -- crates.show()
      -- require("core.utils").load_mappings "crates"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
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

      -- ai based completion
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "hrsh7th/nvim-cmp",
        },
        config = function()
          require("codeium").setup {}
        end,
      },
    },
  },
}

return plugins
