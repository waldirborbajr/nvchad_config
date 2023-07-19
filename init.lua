local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

vim.g.dap_virtual_text = true

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Disable continuation comment on next line
-- autocmd("User", {
--   desc = "no auto comment after pressing o",
--   pattern = "*",
--   command = "setlocal formatoptions-=cro",
-- })
autocmd({ "BufEnter,BufNewFile" }, {
    callback = function()
        vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
    end,
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
-- vim.api.nvim_exec([[
--   augroup auto-format
--       autocmd!
--       autocmd BufWritePre * lua vim.lsp.buf.format({sync = true})
--   augroup END
-- ]], false)
autocmd({ "BufLeave" }, {
    pattern = '*.go,*.py,*.lua,*rust',
    callback = function()
        local bufner = vim.api.nvim_get_current_buf()
        if vim.api.nvim_buf_get_option(bufner, "modified") then
            vim.lsp.buf.format(nil, bufner)
            vim.fn.execute("silent! write")
            -- vim.cmd("silent! wall")
        end
    end,
})
