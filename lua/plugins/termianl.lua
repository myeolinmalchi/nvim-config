return {
  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = function ()
      return {
        size = 20,
        open_mapping = [[<c-\>]],
        direction = 'horizontal'
      }
    end
  }
}
