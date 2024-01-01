require("neo-tree").setup({
  source_selector = {
    winbar = false, 
    statusline = false
  }, 
  window = {
    mappings = {
      ["P"]  ={ "toggle_preview", config = { use_float = true, use_image_nvim = true }}
    }
  }
})
