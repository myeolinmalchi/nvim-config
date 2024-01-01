require('lualine').setup({
  options = {
    theme = 'tokyonight'
  }, 
  sections = {
    lualine_c = {
      {
        'filename', 
        file_status = true, 
        path = 1
      }
    }
  }, 
  inactive_sections = {
    lualine_c = {
      {
        'filename', 
        file_status = true, 
        path = 1
      }
    }
  }
})
