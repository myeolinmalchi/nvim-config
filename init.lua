vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}

  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.showtabline = 2
vim.opt.fillchars = {eob = " "}
vim.opt.hidden = true
vim.opt.title = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.fileencodings = {'utf-8', 'cp949', 'ucs-bom'}
vim.opt.encoding = 'utf-8'
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.hlsearch = true
vim.opt.linebreak = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.iminsert = 1
vim.opt.mouse = 'a'
vim.opt.laststatus = 2
vim.opt.wrap = false
vim.opt.backspace = {'eol', 'start', 'indent'}
vim.opt.cursorline = false
vim.opt.cursorcolumn = false
vim.opt.grepprg = 'grep\\-nH$*'
vim.opt.scrolloff = 4
vim.opt.writebackup = false
vim.opt.viewoptions:remove('options')
vim.opt.path:append('**')
vim.g.base16colorspace = 256
vim.opt.inccommand = 'nosplit'
vim.diagnostic.config {
  float = { border = "rounded" }
}

require('keybindings')
require('lazyvim')

require('plugins/tokyonight')
vim.cmd[[colorscheme tokyonight-night]]

require('plugins/lspconfig')
require('plugins/bufferline')
require('plugins/cmp')
require('plugins/indent_blankline')
require('plugins/lualine')
require('plugins/noice')
require('plugins/copilot')
require('plugins/toggleterm')
require('plugins/treesitter')
require('plugins/prettier')
require('plugins/eslint')
require('plugins/null_ls')
require('plugins/fzflua')
require('plugins/session_manager')
require('plugins/neo_tree')
require('plugins/window_picker')

local async = require('plenary.async')
