-- local autocmd = vim.api.nvim_create_autocmd
require "custom.autocmds"
require "custom.options"

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
