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

-- Dap

M.dap = {
  n = {
    ["<F5>"] = { "<cmd> lua require'dap'.continue() <CR>", "Debug controls | Continue" },
    ["<F10>"] = { "<cmd> lua require'dap'.step_over() <CR>", "Debug controls | Step over" },
    ["<F11>"] = { "<cmd> lua require'dap'.step_into() <CR>", "Debug controls | Step into" },
    ["<F12>"] = { "<cmd> lua require'dap'.step_out() <CR>", "Debug controls | Step out" },
    ["<leader>bp"] = { "<cmd> lua require'dap'.toggle_breakpoint() <CR>", "Toggle line breakpoint" },
    ["<leader>BP"] = {
      "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: ')) <CR>",
      "Set line conditional breakpoint",
    },
    ["<leader>lp"] = {
      "<cmd> lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) <CR>",
      "Set line conditional breakpoint for logging",
    },
    ["<leader>dr"] = { "<cmd> lua require'dap'.repl.open() <CR>", "Open REPL" },
  },
}

return M
