require("neo-tree").setup({
  source_selector = {
    winbar = true, 
    statusline = false
  }, 
  window = {
    mappings = {
      ["P"]  ={ "toggle_preview", config = { use_float = true, use_image_nvim = true }}
    }
  }
})
