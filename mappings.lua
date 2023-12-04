-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │  Str  │  Help page   │  Affected modes                           │  VimL   │
-- │────────────────────────────────────────────────────────────────────────────│
-- │  ''   │  mapmode-nvo │  Normal, Visual, Select, Operator-pending │  :map   │
-- │  'n'  │  mapmode-n   │  Normal                                   │  :nmap  │
-- │  'v'  │  mapmode-v   │  Visual and Select                        │  :vmap  │
-- │  's'  │  mapmode-s   │  Select                                   │  :smap  │
-- │  'x'  │  mapmode-x   │  Visual                                   │  :xmap  │
-- │  'o'  │  mapmode-o   │  Operator-pending                         │  :omap  │
-- │  '!'  │  mapmode-ic  │  Insert and Command-line                  │  :map!  │
-- │  'i'  │  mapmode-i   │  Insert                                   │  :imap  │
-- │  'l'  │  mapmode-l   │  Insert, Command-line, Lang-Arg           │  :lmap  │
-- │  'c'  │  mapmode-c   │  Command-line                             │  :cmap  │
-- │  't'  │  mapmode-t   │  Terminal                                 │  :tmap  │
-- ╰────────────────────────────────────────────────────────────────────────────╯

---@type MappingsTable
local M = {}

M.bplus = {
  n = {
    -- Custom map
    ["-"] = { ":split<cr>", "split" },
    ["|"] = { ":vsplit<cr>", "split vertical" },
    ["<C-a>"] = { "gg<S-v>G", "select all" },
    ["QQ"] = { "<cmd>quit<cr>", desc = "Quit" },
    ["WW"] = { "<cmd>write<cr>", desc = "Write" },
    ["!!"] = { "<cmd>qa!<cr>", desc = "Write" },
    ["<leader>ss"] = { ":%s/", desc = "Search and Replace RegExp" },
    ["<leader>rw"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Replace current word" },
    ["<Tab>"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
    ["<S-Tab>"] = { "<cmd>bprev<cr>", desc = "Prev buffer" },
    ["gh"] = { "<cmd>OpenGithubRepo<cr>", desc = "Open Github Repo" },
    ["<leader>ip"] = { "<cmd> Inspect<cr>", "HL Group Under Cursor" },
    ["<C-d>"] = { "<C-d>zz", "Page down - recenter screen" },
    ["<C-u>"] = { "<C-u>zz", "Page up - recenter screen" },
  },
  v = {
    --copy vscode
    --move selected
    ["<M-Up>"] = { ":m '<-2<cr>gv-gv", "move selected up" },
    ["<M-Down>"] = { ":m '>+1<cr>gv-gv", "move selected down" },
    --copy selected+move
    ["<M-S-Up>"] = { "y`]p`]gv-gv", "copy selected up" },
    ["<M-S-Down>"] = { "yP`[gv-gv", "copy selected down" },
  },
  i = {
    --vscode copy
    --move line
    ["<M-Up>"] = { "<esc>:m .-2<cr>==", "move line up" },
    ["<M-Down>"] = { "<esc>:m .+1<cr>==", "move line down" },
    --copy line+move
    ["<M-S-Up>"] = { "<esc>yyP<end>", "copy line up " },
    ["<M-S-Down>"] = { "<esc>yyp<end>", "copy line down" },
    --convinient
    ["<C-x>"] = { "<C-o>dd", "cut line" },
    ["<C-a>"] = { "<esc>gg<S-v>G", "select all" },
    ["<C-v>"] = { "<C-o>v<S-Right>", "go to visual" },
    ["<C-S-v>"] = { "<C-o>p", "paste" },
    ["<C-i>"] = { "<C-o>:Telescope emoji<cr>", "get emoji" },
    ["<S-Right>"] = { "<end>", "end  of line" },
    ["<S-Left>"] = { "<home>", "start  of line" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>dc"] = { ":lua require'dap'.continue()<cr>", "Continue", opts = { silent = true } },
    ["<leader>do"] = { ":lua require'dap'.step_over()<cr>", "Step Over", opts = { silent = true } },
    ["<leader>di"] = { ":lua require'dap'.step_into()<cr>", "Step Into", opts = { silent = true } },
    ["<leader>du"] = { ":lua require'dap'.step_out()<cr>", "Step Out", opts = { silent = true } },
    ["<leader>db"] = { ":lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint", opts = { silent = true } },
    ["<leader>dB"] = {
      ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
      "Breakpoint Condition",
      opts = { silent = true },
    },
    ["<leader>dd"] = { ":lua require'dapui'.toggle()<cr>", "Dap UI", opts = { silent = true } },
    ["<leader>dl"] = { ":lua require'dap'.run_last()<cr>", "Run Last", opts = { silent = true } },
  },
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>cp"] = {
      function()
        require("crates").show_popup()
      end,
      "Show popup",
    },
    ["<leader>cr"] = {
      function()
        require("crates").reload()
      end,
      "Reload",
    },
    ["<leader>cv"] = {
      function()
        require("crates").show_versions_popup()
      end,
      "Show Versions",
    },
    ["<leader>cf"] = {
      function()
        require("crates").show_features_popup()
      end,
      "Show Features",
    },
    ["<leader>cd"] = {
      function()
        require("crates").show_dependencies_popup()
      end,
      "Show Dependencies Popup",
    },
    ["<leader>cu"] = {
      function()
        require("crates").update_crate()
      end,
      "Update Crate",
    },
    ["<leader>ca"] = {
      function()
        require("crates").update_all_crates()
      end,
      "Update All Crates",
    },
    ["<leader>cU"] = {
      function()
        require("crates").upgrade_crate()
      end,
      "Upgrade Crate",
    },
    ["<leader>cA"] = {
      function()
        require("crates").upgrade_all_crates(true)
      end,
      "Upgrade All Crates",
    },
    ["<leader>cH"] = {
      function()
        require("crates").open_homepage()
      end,
      "Open Homepage",
    },
    ["<leader>cR"] = {
      function()
        require("crates").open_repository()
      end,
      "Open Repository",
    },
    ["<leader>cD"] = {
      function()
        require("crates").open_documentation()
      end,
      "Open Documentation",
    },
    ["<leader>cC"] = {
      function()
        require("crates").open_crates_io()
      end,
      "Open Crate.io",
    },
  },
}

M.rust = {
  n = {
    ["<leader>rra"] = { require("custom.configs.rust-tools").hover_actions, "Hover Actions" },
    ["<leader>rca"] = { "<cmd>RustCodeAction<Cr>", "Code Actions" },
    ["<leader>rrr"] = { "<cmd>RustRunnables<Cr>", "Runnables" },
    ["<leader>rre"] = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    ["<leader>rrc"] = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    ["<leader>rrp"] = { "<cmd>RustParentModule<Cr>", "Parent Module" },
    ["<leader>rrd"] = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
    ["<leader>rrg"] = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
    ["<leader>rrj"] = {
      function()
        require("rust-tools").join_lines.join_lines()
      end,
      "Join Lines",
    },
    ["<leader>rrt"] = {
      function()
        require("rust-tools")._CARGO_TEST()
      end,
      "Cargo Test",
    },
    ["<leader>rrR"] = {
      function()
        require("rust-tools/workspace_refresh")._reload_workspace_from_cargo_toml()
      end,
      "Reload Workspace",
    },
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

return M
