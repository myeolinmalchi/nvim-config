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


-- Better register
keymap('x', 'p', '"_dP', opts)
keymap('n', 'x', '"_x', opts)


-- Clear search highlights
keymap('n', '<esc>', ':noh<CR><CR>', opts)


-- Better window movement
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

keymap('t', '<esc>', '<C-\\><C-n>', opts)
keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', opts)
keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', opts)
keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', opts)
keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', opts)


-- Save current file
keymap('n', '<C-s>', ':w<CR>', opts)
keymap('i', '<C-s>', '<C-o>:w<CR><Esc>', opts)


-- Split window
function _G.split_opts(split_cmd)
  return {
    noremap = true,
    silent = true,
    callback = function()
      cmd(split_cmd .. ' | enew')
      cmd('bp|sp|bn|bd')
      cmd('Neotree filesystem current')
    end
  }
end
keymap('n', '<leader>h', '', split_opts('leftabove vsplit'))
keymap('n', '<leader>l', '', split_opts('rightbelow vsplit'))
keymap('n', '<leader>j', '', split_opts('belowright split'))
keymap('n', '<leader>k', '', split_opts('split'))


-- Navigate between buffers
keymap('n', '<S-h>', ':bprev<cr>', opts)
keymap('n', '<S-l>', ':bnext<cr>', opts)


-- Open empty buffer
keymap('n', '<C-t>', ':enew<cr> <BAR> CtrlP<cr>', opts)


-- Close buffer
vim.keymap.del('n', '<C-w>d')
vim.keymap.del('n', '<C-w><C-D>')
keymap('n', '<C-q>', ':bp<bar>sp<bar>bn<bar>bd<bar>q<CR>', opts)
keymap('n', '<C-w>', ':bp<bar>sp<bar>bn<bar>bd<CR>', opts)

-- Toggle zen-mode
keymap('', '<Leader>z', ':lua require("zen-mode").toggle()<CR>', opts)


-- Restart LSP
keymap('n', '<Leader>cr', ':LspRestart<CR>', opts)


-- Choose buffer in tabline
keymap('', 'gt', ':BufferLinePick<CR>', opts)
