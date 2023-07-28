local rust = require("rust-tools")

local package_dir = os.getenv("LOCALAPPDATA") .. "\\nvim-data\\mason\\packages\\codelldb\\extension\\"
local codelldb = package_dir .. "adapter\\codelldb.exe"
local lldblib = package_dir .. "lldb\\bin\\liblldb.dll"

rust.setup {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "K", rust.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<leader>la", rust.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(
      codelldb,
      lldblib
    )
  },
  tools = {
    inlay_hints = {
      auto = false
    }
  }
}
