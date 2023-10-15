require "custom.autocmds"

---@type MappingsTable
local M = {}

M.bplus = {
  n = {
    -- Custom map
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
