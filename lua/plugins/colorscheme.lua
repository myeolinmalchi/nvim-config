return {
  {
    "folke/tokyonight.nvim", 
    lazy = true, 
    opts = {
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      lualine_bold = true,
    }
  }
}
