require "custom.autocmds"

vim.g.dap_virtual_text = true

vim.opt.relativenumber = true

vim.opt.termguicolors = true

vim.opt.conceallevel = 2
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.scrolloff = 3

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
