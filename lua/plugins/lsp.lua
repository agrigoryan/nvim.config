-- Diagnostic config
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, source = "if_many", prefix = "icons" },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local o = function(desc)
      return { buffer = buf, desc = desc }
    end
    vim.keymap.set("n", "K", vim.lsp.buf.hover, o("Hover"))
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, o("Code Action"))
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, o("Rename"))
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, o("Line Diagnostics"))
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, o("Signature Help"))
  end,
})

-- Servers (vim.lsp.config + vim.lsp.enable)
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      codeLens = { enable = true },
      completion = { callSnippet = "Replace" },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
    },
  },
})

-- mason-lspconfig's automatic_enable handles vim.lsp.enable() for installed servers
