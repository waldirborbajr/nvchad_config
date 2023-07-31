local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  -- general
  b.diagnostics.trail_space,
  b.formatting.trim_newlines,
  b.formatting.trim_whitespace,

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- docker
  b.diagnostics.hadolint,

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt,

  -- Completion
  b.completion.luasnip,

  -- go
  -- b.diagnostics.golangci_lint.with { extra_args = { "--enable-all" } },
  -- go install mvdan.cc/gofumpt@latest
  b.formatting.gofumpt,
  -- b.formatting.gofmt,
  b.formatting.tidy,
  b.formatting.goimports,
  -- go install -v github.com/incu6us/goimports-reviser/v3@latest
  b.formatting.goimports_reviser,
  -- go install github.com/segmentio/golines@latest
  b.formatting.golines,

  -- shell
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
  b.formatting.shfmt,

  -- terraform
  -- b.diagnostics.tfsec,
  -- b.formatting.terraform_fmt,

  -- toml
  b.formatting.taplo,

  -- yaml
  b.diagnostics.yamllint,
  b.formatting.yamlfmt,
}

local autocmd = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = autocomandgroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = autocmd,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,

  on_attach = on_attach,
}
