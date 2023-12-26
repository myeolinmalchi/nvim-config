require("bufferline").setup{
  options = {
    offsets = {
      {
        filetype = "NvimTree", 
        text = "NvimTree", 
        highlight = "Directory", 
        text_align = "center", 
        separator = false
      }
    }, 
    numbers = "buffer_id", 
    indicator = {
      --style = 'underline', 
    }, 
    color_icons = true, 
    diagnostics = "nvim_lsp", 
    show_close_icon = true, 
    show_buffer_close_icons = true, 
    separator_style = "thick", 
  }
}

diagnostics_indicator = function(count, level, diagnostics_dict, context)
  if context.buffer:current() then
    return ''
  end

  return ''
end
