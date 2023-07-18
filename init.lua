local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

vim.g.dap_virtual_text = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Disable continuation comment on next line
autocmd("User", {
  desc = "no auto comment after pressing o",
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- Open Github repository
command("OpenGithubRepo", function(_)
  local ghpath = vim.api.nvim_eval "shellescape(expand('<cfile>'))"
  local formatpath = ghpath:sub(2, #ghpath - 1)
  local repourl = "https://www.github.com/" .. formatpath
  vim.fn.system { "xdg-open", repourl }
end, {
  desc = "Open Github Repo",
  force = true,
})

-- Remember cursor position when reopening files
vim.api.nvim_exec([[
  augroup remember-cursor-position
      autocmd!
      autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
  augroup END
]], false)

-- Auto format on save
vim.api.nvim_exec([[
  augroup auto-format
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format({sync = true})
  augroup END
]], false)
