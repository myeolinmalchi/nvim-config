vim.g.mapleader = " "

-- Remapping keys for navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap = true})

-- NERDTree, Tagbar, and LSP mappings
--vim.api.nvim_set_keymap('n', '<Leader>nt', ':NERDTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>nt', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>tg', ':TagbarToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>rc', ':rightbelow vnew $MYVIMRC<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Leader>cr', ':LspRestart<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<esc>', ':noh<CR><CR>', {noremap = true})

-- Window navigation mappings
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', {noremap = true})

-- Save file mappings
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR><Esc>', {noremap = true})

-- Split window mappings
vim.api.nvim_set_keymap('n', '<leader>h', ':vsp +<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':vsp -<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':sp -<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':sp +<CR>', {noremap = true})

-- Git mappings
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add %<TAB><Cr> G status<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<Cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit -m ', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':G log<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Gdiff<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>gps', ':Git push<CR>', {noremap = true})

-- Buffergator settings
vim.g.buffergator_viewport_split_policy = 'R'
vim.g.buffergator_suppress_keymaps = 1

-- Buffer navigation mappings
vim.api.nvim_set_keymap('n', '<S-h>', ':bprev<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':enew<cr> <BAR> CtrlP<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-q>', ':q<cr>', {noremap = true})

-- Close buffer mapping
vim.api.nvim_set_keymap('', '<C-w>', ':bp<bar>sp<bar>bn<bar>bd<CR>', {noremap = true})

