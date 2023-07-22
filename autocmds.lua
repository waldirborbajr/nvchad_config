-- replace string from file
local function sed(from, to, fname)
  vim.cmd(string.format("silent !sed -i 's/%s/%s/g' %s", from, to, fname))
end

local autocmd = vim.api.nvim_create_autocmd

-- Disable continuation comment on next line
autocmd("User", {
  desc = "no auto comment after pressing o",
  pattern = "*",
  command = "setlocal formatoptions-=cro",
})

-- Remember cursor position when reopening files
vim.api.nvim_exec([[
  augroup remember-cursor-position
      autocmd!
      autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
  augroup END
]], false)

-- Format GO file
local fmt_augroup = vim.api.nvim_create_augroup("lsp_fmt", { clear = true })
autocmd("BufWritePre", {
	group = fmt_augroup,
	callback = function()
		require('go.format').goimport()
	end
})
