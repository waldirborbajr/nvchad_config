local M = {}

M.bplus = {
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

-- Custom mappings
M.custom = {
  n = {
    ["<leader>v"] = { "<C-v>", "Enter visual block mode" },
    ["<C-z>"] = { "u", "Undo" },
    ["<C-y>"] = { "<C-r>", "Redo" },
    ["<C-d>"] = { "<C-d>zz", "Half page jump down" },
    ["<C-u>"] = { "<C-u>zz", "Half page jump up" },
    ["<C-f>"] = { "<C-f>zz", "Page jump down" },
    ["<C-b>"] = { "<C-b>zz", "Page jump up" },
    ["<S-Down>"] = { "<C-d>zz", "Page jump down" },
    ["<S-Up>"] = { "<C-u>zz", "Page jump up" },
    ["n"] = { "nzzzv", "Seek next search term" },
    ["N"] = { "Nzzzv", "Seek next search term backwards" },
    ["<leader>c"] = { [["_c]], "Change without yanking content" },
    ["<leader>C"] = { [["_C]], "Change without yanking content" },
    ["<leader>de"] = { [["_d]], "Delete without yanking content" },
    ["<leader>D"] = { [["_D]], "Delete without yanking content" },
    ["<leader>rw"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace current word" },
    ["<C-k>"] = { "10k", "Fast scroll up" },
    ["<C-Up>"] = { "10k", "Fast scroll up" },
    ["<C-j>"] = { "10j", "Fast scroll down" },
    ["<C-Down>"] = { "10j", "Fast scroll down" },
    ["<leader>la"] = { vim.lsp.buf.code_action, "LSP code action" },
    ["<leader>ld"] = { vim.lsp.buf.type_definition, "LSP type definition" },
    ["<leader>sh"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },
    ["<leader>jc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,
      "Jump to current context",
    },
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>fd"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },
  },
  i = {
    ["<C-z>"] = { "<C-o>u", "Undo" },
    ["<C-y>"] = { "<C-o><C-r>", "Redo" },
  },
  v = {
    [">"] = { ">gv", "Shift text right" },
    ["<"] = { "<gv", "Shift text left" },
    ["<Tab>"] = { ">gv", "Shift text right" },
    ["<S-Tab>"] = { "<gv", "Shift text left" },
    ["J"] = { ":m '>+1<CR>gv=gv", "Move selected block up" },
    ["<S-Down>"] = { ":m '>+1<CR>gv=gv", "Move selected block down" },
    ["K"] = { ":m '<-2<CR>gv=gv", "Move selected block down" },
    ["<S-Up>"] = { ":m '<-2<CR>gv=gv", "Move selected block up" },
    ["<leader>c"] = { [["_c]], "Change without yanking content" },
    ["<leader>d"] = { [["_d]], "Delete without yanking content" },
  },
  x = {
    ["p"] = { [["_dP]], "Paste copied content and replace selection" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
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

return M
