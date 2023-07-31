-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

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
vim.api.nvim_exec(
  [[
  augroup remember-cursor-position
      autocmd!
      autocmd BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"zz" | endif
  augroup END
]],
  false
)

-- Format GO file
local fmt_augroup = vim.api.nvim_create_augroup("lsp_fmt", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fmt_augroup,
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--     vim.lsp.buf.code_action { context = { only = { "source.organizeImports" } }, apply = true }
--   end,
-- })

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

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
-- autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     vim.lsp.buf.formatting_sync()
--   end,
-- })

vim.g.dap_virtual_text = true
vim.opt.conceallevel = 2
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.scrolloff = 3
