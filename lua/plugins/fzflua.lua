require('fzf-lua').setup {
  winopts = {
    width = 0.80, 
    height = 0.40, 
    row = 0.1
  }, 
}

vim.api.nvim_set_keymap("n", "<C-p>", ":lua require('fzf-lua').files({ cwd = './src' })<Cr>", {noremap = true, silent = true})
