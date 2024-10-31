return {
  "nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      zls = {},
      rust_analyzer = {},
      clangd = {},
      ruff = {},
    },
  },
}
