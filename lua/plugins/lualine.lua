require('lualine').setup({
  options = {
    theme = 'base16'
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
  --[[
  tabline = {
    lualine_a = {'buffers'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  }
  --]]
})
