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

  -- go
  b.diagnostics.golangci_lint.with { extra_args = { "--enable-all" } },
  b.formatting.gofmt,
  b.formatting.goimports,
  b.formatting.goimports_reviser,

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

null_ls.setup {
  debug = true,
  sources = sources,
}
