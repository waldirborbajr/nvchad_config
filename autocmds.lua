-- Open Github repository
vim.api.nvim_create_user_command("OpenGithubRepo", function(_)
  local ghpath = vim.api.nvim_eval "shellescape(expand('<cfile>'))"
  local formatpath = ghpath:sub(2, #ghpath - 1)
  local repourl = "https://www.github.com/" .. formatpath
  vim.fn.system { "xdg-open", repourl }
end, {
  desc = "Open Github Repo",
  force = true,
})

-- Disable continuation comment on next line
vim.api.nvim_create_autocmd("User", {
  desc = "no auto comment after pressing o",
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- Remember cursor position when reopening files
-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
-- autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
vim.api.nvim_exec(
  [[
  augroup remember-cursor-position
      autocmd!
      autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END
]],
  false
)

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  callback = function()
    local bufner = vim.api.nvim_get_current_buf()
    if vim.api.nvim_buf_get_option(bufner, "modified") then
      -- vim.lsp.buf.format({ async = true })
      vim.fn.execute "silent! write"
      -- vim.cmd("silent! wall")
    end
  end,
})

-- remove trailing spaces when save
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = { "*" },
--   command = [[%s/\s\+$//e]],
-- })
