return {
  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = function ()
      function _G.set_terminal_keymaps()
        local _opts = {noremap = true}
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], _opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], _opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], _opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], _opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], _opts)

        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      end
      return {
        size = 20,
        open_mapping = [[<c-\>]],
        direction = 'horizontal'
      }
    end
  }
}
