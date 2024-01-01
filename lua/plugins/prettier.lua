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
  ["null-ls"] = {
    condition = function()
      return prettier.config_exists({
        check_package_json = true,
      })
    end, 
    runtime_condition = function(params)
      return true
    end,
    timeout = 5000
  }
})

vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>(prettier-format)', {noremap = true})
vim.api.nvim_set_keymap('x', '<leader>f', '<Plug>(prettier-format)', {noremap = true})
