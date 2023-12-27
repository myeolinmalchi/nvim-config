vim.g.mapleader = " "

-- Remapping keys for navigation
vim.api.nvim_set_keymap('n', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('n', 'k', 'gk', {noremap = true})
vim.api.nvim_set_keymap('n', 'gj', 'j', {noremap = true})
vim.api.nvim_set_keymap('n', 'gk', 'k', {noremap = true})

vim.api.nvim_set_keymap('n', '<Leader>nt', ':Neotree current toggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>nf', ':Neotree buffers current toggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>tg', ':TagbarToggle<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>cr', ':LspRestart<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<esc>', ':noh<CR><CR>', {noremap = true, silent = true})

-- Window navigation mappings
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', {noremap = true})
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', {noremap = true})
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', {noremap = true})
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', {noremap = true})

-- Save file mappings
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<C-o>:w<CR><Esc>', {noremap = true, silent = true})

-- 윈도우 분할
vim.api.nvim_set_keymap('n', '<leader>h', ':leftabove vnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>l', ':rightbelow vnew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>j', ':belowright split | enew<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>k', ':split | enew<CR>', {noremap = true, silent = true})

-- 윈도우 크기 조절
vim.api.nvim_set_keymap('n', '<C-Up>', ':resize +2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Down>', ':resize -2<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +4<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -4<CR>', {noremap = true, silent = true})

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
vim.api.nvim_set_keymap('n', '<S-h>', ':bprev<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-l>', ':bnext<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-t>', ':enew<cr> <BAR> CtrlP<cr>', {noremap = true, silent =true})
vim.api.nvim_set_keymap('n', '<C-q>', ':bp<bar>sp<bar>bn<bar>bd<bar>q<CR>', {noremap = true, silent = true})

-- Close buffer mapping
vim.api.nvim_set_keymap('', '<C-w>', ':bp<bar>sp<bar>bn<bar>bd<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('', '<Leader>z', ':ZenMode<CR>', {noremap = true, silent = true})

-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
