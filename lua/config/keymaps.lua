vim.g.mapleader = " "

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set
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

-- Better paste
keymap('', 'p', '"0p', { noremap = true, vmap = true, silent = true })


-- Clear search highlights
keymap('n', '<esc>', ':noh<CR><CR>', opts)

-- Better window movement
keymap({'n','i'}, '<C-h>', '<C-w>h', opts)
keymap({'n','i'}, '<C-j>', '<C-w>j', opts)
keymap({'n','i'}, '<C-k>', '<C-w>k', opts)
keymap({'n','i'}, '<C-l>', '<C-w>l', opts)

-- Save current file
keymap('n', '<C-s>', ':w<CR>', opts)
keymap('i', '<C-s>', '<C-o>:w<CR><Esc>', opts)

-- Split window
keymap('n', '<leader>h', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('leftabove vsplit | enew')
    cmd('bp|sp|bn|bd')
    cmd('Neotree filesystem current')
  end
})
keymap('n', '<leader>l', '', {
  noremap = true,
  silent = true,
  callback = function()
    cmd('rightbelow vsplit | enew')
    --cmd('bp|sp|bn|bd')
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
