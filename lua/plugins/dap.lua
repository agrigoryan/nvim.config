local dap = require("dap")
local dapui = require("dapui")

-- DAP UI
dapui.setup()
require("nvim-dap-virtual-text").setup()

-- Auto open/close UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Language-specific
require("dap-go").setup()
require("dap-python").setup("python3")

-- Mason DAP (auto-install debug adapters)
require("mason-nvim-dap").setup({
  ensure_installed = { "delve", "debugpy", "js-debug-adapter" },
  automatic_installation = true,
})

-- Keymaps
local map = vim.keymap.set
map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dc", dap.continue, { desc = "Continue" })
map("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to Cursor" })
map("n", "<leader>di", dap.step_into, { desc = "Step Into" })
map("n", "<leader>do", dap.step_over, { desc = "Step Over" })
map("n", "<leader>dO", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dr", dap.restart, { desc = "Restart" })
map("n", "<leader>ds", dap.terminate, { desc = "Stop" })
map("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
map("n", "<leader>de", function() dapui.eval() end, { desc = "Eval" })
map("v", "<leader>de", function() dapui.eval() end, { desc = "Eval" })
