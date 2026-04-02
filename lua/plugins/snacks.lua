require("snacks").setup({
  -- Enabled features
  dashboard = { enabled = false },
  notifier = { enabled = true },
  picker = {
    sources = {
      explorer = {
        ignored = true,
        hidden = true,
        watch = true,
      },
    },
  },
  explorer = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  quickfile = { enabled = true },
  input = { enabled = true },
  lazygit = { enabled = true },
  terminal = { enabled = true },

  -- Disabled (animations you had off)
  scroll = { enabled = false },
  indent = { enabled = false },
})

-- Set statuscolumn after snacks is loaded
vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
