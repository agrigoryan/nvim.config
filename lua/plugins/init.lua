local gh = function(repo)
  return "https://github.com/" .. repo
end

-- Build hook: recompile treesitter parsers after install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" and ev.data.kind ~= "delete" then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- Theme
  { src = gh("catppuccin/nvim"), name = "catppuccin" },

  -- UI / Swiss army knife
  gh("folke/snacks.nvim"),

  -- Mini (icons, pairs, surround)
  gh("echasnovski/mini.nvim"),

  -- Completion
  gh("saghen/blink.cmp"),

  -- LSP
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("mason-org/mason-lspconfig.nvim"),

  -- Treesitter
  gh("nvim-treesitter/nvim-treesitter"),

  -- Tmux navigation
  gh("christoomey/vim-tmux-navigator"),

  -- Which-key
  gh("folke/which-key.nvim"),

  -- Git signs
  gh("lewis6991/gitsigns.nvim"),

  -- Formatting
  gh("stevearc/conform.nvim"),

  -- HTTP client
  gh("mistweaverco/kulala.nvim"),

  -- Find & replace
  gh("MagicDuck/grug-far.nvim"),

  -- TODO comments
  gh("folke/todo-comments.nvim"),

  -- Debugging
  gh("mfussenegger/nvim-dap"),
  gh("rcarriga/nvim-dap-ui"),
  gh("nvim-neotest/nvim-nio"),
  gh("theHamsta/nvim-dap-virtual-text"),
  gh("leoluz/nvim-dap-go"),
  gh("mfussenegger/nvim-dap-python"),
  gh("jay-babu/mason-nvim-dap.nvim"),
}, { confirm = false })

-- Load plugin configs
require("plugins.catppuccin")
require("plugins.snacks")
require("plugins.mason")
require("plugins.lsp")
require("plugins.completion")
require("plugins.treesitter")
require("plugins.gitsigns")
require("plugins.conform")
require("plugins.whichkey")
require("plugins.mini")
require("plugins.kulala")
require("plugins.grugfar")
require("plugins.todocomments")
require("plugins.dap")
