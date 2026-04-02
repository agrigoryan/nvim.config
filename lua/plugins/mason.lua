require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "gopls",
    "lua_ls",
    "neocmake",
    "pyright",
    "tailwindcss",
    "vtsls",
    "zls",
  },
  automatic_enable = true,
})
