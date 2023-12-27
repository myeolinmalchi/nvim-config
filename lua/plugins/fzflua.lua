local colors = require("tokyonight.colors").setup()
local util = require("tokyonight.util")

require('fzf-lua').setup {
  winopts = {
    width = 0.70, 
    height = 0.40, 
    row = 0.1, 
  }, 
}

vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('fzf-lua').files({ cwd = './' })<Cr>", {noremap = true, silent = true})
