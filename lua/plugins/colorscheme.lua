return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", lazy = true },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",
      styles = {
        functions = {},
      },
    },
  },
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "macchiato",
      no_italic = true,
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "nordic",
      colorscheme = "catppuccin",
    },
  },
}
