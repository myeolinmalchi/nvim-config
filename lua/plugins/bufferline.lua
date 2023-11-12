require("bufferline").setup{
  options = {
    offsets = {
      {
        filetype = "NvimTree", 
        text = "File Explorer", 
        highlight = "Directory", 
        text_align = "center", 
        separator = true
      }
    }, 
    diagnostics = "nvim_lsp", 
    separator_style = {"", ""},
    show_close_icon = false, 
    show_buffer_close_icons = false, 
    separator_style = "thick"
  }
}
