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
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "update crates",
    },
  },
}

M.rust = {
  n = {
    ["<leader>ca"] = { ":RustCodeAction<cr>", opts = { silent = true } },
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
