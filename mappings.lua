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

    ["gh"] = { "<cmd>OpenGithubRepo<cr>", desc = "Open Github Repo" },

    ["<leader>ip"] = { "<cmd> Inspect<cr>", "HL Group Under Cursor" },

    -- Custom navigation
    ["<C-d>"] = { "<C-d>zz", desc = "Half page jump down" },
    ["<C-u>"] = { "<C-u>zz", desc = "Half page jump up" },
    ["<C-f>"] = { "<C-f>zz", desc = "Page jump down" },
    ["<C-b>"] = { "<C-b>zz", desc = "Page jump up" },
    ["<C-k>"] = { "10k", desc = "Fast scroll up" },
    ["<C-Up>"] = { "10k", desc = "Fast scroll up" },
    ["<C-j>"] = { "10j", desc = "Fast scroll down" },
    ["<C-Down>"] = { "10j", desc = "Fast scroll down" },
  },
  v = {
    --copy vscode
    --move selected
    ["<M-Up>"] = { ":m '<-2<cr>gv-gv", "move selected up" },
    ["<M-Down>"] = { ":m '>+1<cr>gv-gv", "move selected down" },
    --copy selected+move
    ["<M-S-Up>"] = { "y`]p`]gv-gv", "copy selected up" },
    ["<M-S-Down>"] = { "yP`[gv-gv", "copy selected down" },

    [">"] = { ">gv", desc = "Shift text right" },
    ["<"] = { "<gv", desc = "Shift text left" },
    ["<Tab>"] = { ">gv", desc = "Shift text right" },
    ["<S-Tab>"] = { "<gv", desc = "Shift text left" },
    ["J"] = { ":m '>+1<CR>gv=gv", desc = "Move selected block up" },
    ["<S-Down>"] = { ":m '>+1<CR>gv=gv", desc = "Move selected block down" },
    ["K"] = { ":m '<-2<CR>gv=gv", desc = "Move selected block down" },
    ["<S-Up>"] = { ":m '<-2<CR>gv=gv", desc = "Move selected block up" },
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

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

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

return M
