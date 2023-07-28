local dap = require "dap"
local dapui = require "dapui"
local core = require "custom.configs.core"

-- dapui.setup()
dapui.setup(core.dapui)

require "nvim-dap-virtual-text"

local debug_buffer = 0

-- Set debugging keymappings in normal mode
local function set_mappings()
  debug_buffer = vim.api.nvim_get_current_buf()
  vim.keymap.set("n", "s", dap.step_over, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "S", dap.step_into, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "o", dap.step_out, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "c", dap.continue, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "C", dap.reverse_continue, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "O", dap.run_to_cursor, { noremap = true, silent = true, buffer = true })
  vim.keymap.set("n", "b", dap.step_back, { noremap = true, silent = true, buffer = true })
end

-- Undo debugging keymappings
local function delete_mappings()
  vim.keymap.del("n", "s", { buffer = debug_buffer })
  vim.keymap.del("n", "S", { buffer = debug_buffer })
  vim.keymap.del("n", "o", { buffer = debug_buffer })
  vim.keymap.del("n", "c", { buffer = debug_buffer })
  vim.keymap.del("n", "C", { buffer = debug_buffer })
  vim.keymap.del("n", "O", { buffer = debug_buffer })
  vim.keymap.del("n", "b", { buffer = debug_buffer })
end

-- Close nvim-tree, open DAP UI and set debugging key mappings when a debugging session is initialized

--   dapui.open()
--   set_mappings()
-- end

-- Delete mappings and close DAP UI when a debugging session is terminated
-- dap.listeners.after.event_terminated["dapui_config"] = function()
--   delete_mappings()
--   dapui.close()
-- end

-- IDK when this event is triggered TBH
-- dap.listeners.after.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

dap.listeners.before.event_initialized["dapui_config"] = function()
  local api = require "nvim-tree.api"
  local view = require "nvim-tree.view"
  if view.is_visible() then
    api.tree.close()
  end

  for _, winnr in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local bufnr = vim.api.nvim_win_get_buf(winnr)
    if vim.api.nvim_get_option_value("ft", { buf = bufnr }) == "dap-repl" then
      return
    end
  end
  dapui:open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  vim.cmd "stopinsert"
  dapui:close()
end
dap.listeners.after.event_exited["dapui_config"] = function()
  vim.cmd "stopinsert"
  dapui:close()
end

-- Icons for debugging breakpoints and stop points
vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "DapBreakpoint", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "󰜵", texthl = "DapStoppedText", linehl = "DapStopped", numhl = "" })
