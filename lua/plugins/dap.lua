local function setup_dap()
  local dap = require("dap")
  local dapui = require("dapui")

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

  return dap, dapui
end

local dap, dapui

local function ensure_dap()
  if not dap then
    dap, dapui = setup_dap()
  end
  return dap, dapui
end

local map = vim.keymap.set
map("n", "<leader>db", function() ensure_dap().toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
map("n", "<leader>dB", function() ensure_dap().set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Conditional Breakpoint" })
map("n", "<leader>dc", function() ensure_dap().continue() end, { desc = "Continue" })
map("n", "<leader>dC", function() ensure_dap().run_to_cursor() end, { desc = "Run to Cursor" })
map("n", "<leader>di", function() ensure_dap().step_into() end, { desc = "Step Into" })
map("n", "<leader>do", function() ensure_dap().step_over() end, { desc = "Step Over" })
map("n", "<leader>dO", function() ensure_dap().step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() ensure_dap().restart() end, { desc = "Restart" })
map("n", "<leader>ds", function() ensure_dap().terminate() end, { desc = "Stop" })
map("n", "<leader>du", function() local _, ui = ensure_dap(); ui.toggle() end, { desc = "Toggle DAP UI" })
map("n", "<leader>de", function() local _, ui = ensure_dap(); ui.eval() end, { desc = "Eval" })
map("v", "<leader>de", function() local _, ui = ensure_dap(); ui.eval() end, { desc = "Eval" })
