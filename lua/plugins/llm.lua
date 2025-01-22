return {
  {
    'github/copilot.vim',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    config = function()
      local chat = require 'CopilotChat'
      chat.setup()
      vim.keymap.set('n', '<leader>cc', function()
        chat.toggle {}
      end, { desc = 'Toggle Copilot Chat' })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
