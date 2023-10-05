local M = {}

M = {
    ensure_installed = {
        -- 'rust',
        'lua',
        -- 'toml',
        'json',
        'markdown',
        'markdown_inline',
        -- 'python',
        'go',
        'bash',
    },

  auto_install = true,
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'markdown' },
    },
    autotag = {
    enable = true
  }
}

return M
