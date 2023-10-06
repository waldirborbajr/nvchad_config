-- local dap = require('dap')

vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "🔵", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define('DapBreakpointRejected', { text = 'R', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define("DapLogPoint", { text = "⚪", texthl = "", linehl = "", numhl = "" })
-- vim.fn.sign_define('DapStopped', { text = '→', texthl = '', linehl = 'debugPC', numhl = '' })

return {}
