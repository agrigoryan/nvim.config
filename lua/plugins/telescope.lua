return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          'node_modules',
          'vendor',
          'target',
          'dist',
          '.git',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'

    vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Find Files (Root Dir)' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files (Root Dir)' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent' })
    vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Files (git-files)' })

    vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Commits' })
    vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Status' })

    vim.keymap.set('n', '<leader>s"', builtin.registers, { desc = 'Registers' })
    vim.keymap.set('n', '<leader>sa', builtin.autocommands, { desc = 'Auto Commands' })
    vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find, { desc = 'Buffer' })
    vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = 'Comand History' })
    vim.keymap.set('n', '<leader>sC', builtin.commands, { desc = 'Comands' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Help Pages' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = 'Marks' })
    vim.keymap.set('n', '<leader>so', builtin.vim_options, { desc = 'Vim Options' })
    vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = 'Quickfix List' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fc', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })
  end,
}
