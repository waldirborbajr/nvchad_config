-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local create_cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

-- Open Github repository
create_cmd("OpenGithubRepo", function(_)
  local ghpath = vim.api.nvim_eval "shellescape(expand('<cfile>'))"
  local formatpath = ghpath:sub(2, #ghpath - 1)
  local repourl = "https://www.github.com/" .. formatpath
  vim.fn.system { "xdg-open", repourl }
end, {
  desc = "Open Github Repo",
  force = true,
})

-- Disable continuation comment on next line
autocmd("User", {
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
autocmd("BufWritePre", {
  group = fmt_augroup,
  callback = function()
    require("go.format").goimport()
  end,
})

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

vim.g.dap_virtual_text = true
vim.opt.conceallevel = 2
vim.opt.spell = true
vim.opt.spelllang = { "en" }
vim.opt.scrolloff = 3
