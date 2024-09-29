vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Better cursor movement
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('n', 'gj', 'j', opts)
keymap('n', 'gk', 'k', opts)


-- Clear search highlights
keymap('n', '<esc>', ':noh<CR><CR>', opts)

-- Better window movement
keymap('', '<C-h>', '<C-w>h', { noremap = true })
keymap('', '<C-j>', '<C-w>j', { noremap = true })
keymap('', '<C-k>', '<C-w>k', { noremap = true })
keymap('', '<C-l>', '<C-w>l', { noremap = true })

-- Save current file
keymap('n', '<C-s>', ':w<CR>', opts)
keymap('i', '<C-s>', '<C-o>:w<CR><Esc>', opts)

-- Split window
keymap('n', '<leader>h', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('leftabove vnew')
    cmd('bp|sp|bn|bd')
    cmd('Neotree filesystem current')
  end
})
keymap('n', '<leader>l', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('rightbelow vnew')
    cmd('bp|sp|bn|bd')
    cmd('Neotree filesystem current')
  end
})
keymap('n', '<leader>j', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('belowright split | enew')
    cmd('bp|sp|bn|bd')
    cmd('Neotree filesystem current')
  end
})
keymap('n', '<leader>k', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('split | enew')
    cmd('bp|sp|bn|bd')
    cmd('Neotree filesystem current')
  end
})

-- Navigate between buffers
keymap('n', '<S-h>', ':bprev<cr>', opts)
keymap('n', '<S-l>', ':bnext<cr>', opts)

-- Open empty buffer
keymap('n', '<C-t>', ':enew<cr> <BAR> CtrlP<cr>', opts)

-- Close buffer
keymap('n', '<C-q>', ':bp<bar>sp<bar>bn<bar>bd<bar>q<CR>', opts)
keymap('', '<C-w>', ':bp<bar>sp<bar>bn<bar>bd<CR>', opts)

-- Toggle zen-mode
keymap('', '<Leader>z', ':lua require("zen-mode").toggle()<CR>', opts)

-- Restart LSP
keymap('n', '<Leader>cr', ':LspRestart<CR>', opts)

-- Choose buffer in tabline
keymap('', 'gt', ':BufferLinePick<CR>', opts)

keymap('', '<Leader><CR>', ':ObsidianOpen<CR>', opts)
