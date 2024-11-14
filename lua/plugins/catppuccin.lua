return {
  'catppuccin/nvim',
  config = function()
    require('catppuccin').setup {
      flavour = 'macchiato',
      no_italic = true,
    }
  end,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
