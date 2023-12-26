local prettier = require("prettier")

prettier.setup({
  bin = 'prettier',
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
    "astro"
  },
})

vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(prettier-format)', {noremap = true})
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(prettier-format)', {noremap = true})
