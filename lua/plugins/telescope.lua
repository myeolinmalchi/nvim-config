require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules", 
      "dist", 
      "__pycache__",
    }, 
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown"
    }
  }, 
  extensions = {
    fzf = {
      fuzzy = true, 
      override_generic_sorter = true, 
      override_file_sorter = true, 
      case_mode = "smart_case"
    }
  }
}

require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<c-;>', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
