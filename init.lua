require "custom.autocmds"

vim.g.dap_virtual_text = true
vim.opt.termguicolors = true
vim.o.spell = true

-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
