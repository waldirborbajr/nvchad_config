---@type MappingsTable
local M = {}

M.custom = {
  n = {
    -- Custom map
    ["QQ"] = { "<cmd>quit<cr>", desc = "Quit" },
    ["WW"] = { "<cmd>write<cr>", desc = "Write" },
    ["!!"] = { "<cmd>qa!<cr>", desc = "Write" },
    ["<leader>ss"] = { ":%s/", desc = "Search and Replace RegExp" },
    ["<Tab>"] = { "<cmd>bnext<cr>", desc = "Next buffer" },
    ["<S-Tab>"] = { "<cmd>bprev<cr>", desc = "Prev buffer" },
    ["gh"] = { "<cmd>OpenGithubRepo<cr>", desc = "Open Github Repo" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>du"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    }
  }
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

-- more keybinds!

return M
