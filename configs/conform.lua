--type conform.options
local options = {
  keys = {
      -- stylua: ignore
      { '=', function() require('conform').format { async = true, lsp_fallback = true } end, mode = '', desc = 'Format buffer' },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    async = false,
    timeout_ms = 500,
    quiet = true,
    lsp_fallback = true,
  },

  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt", "gofumpt", "goimports", "golines" },
    markdown = { "prettier" },
    json = { "prettierd" },
    yaml = { "prettierd" },
    rust = { "rustfmt" },
    toml = { "taplo" },
    sh = { "shfmt" },
    zsh = { "shfmt" },
    bash = { "shfmt" },
    -- Missing Markdownlint
    ["*"] = { "trim_whitespace", "trim_newlines" },
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2", "-ci" },
    },
    beautysh = {
      prepend_args = { "-i", "2" },
    },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
