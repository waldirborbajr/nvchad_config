require("flutter-tools").setup {
  debugger = {
    enabled = true
  },
  lsp = {
    on_attach = function(client, bufnr)
      LspKeymaps(bufnr)
    end
  }
}

require("telescope").load_extension("flutter")
require("core.utils").load_mappings("flutter_tools")
