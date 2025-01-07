return {
  {
    "folke/tokyonight.nvim", 
    lazy = true,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      lualine_bold = true,
    }
  },
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = function()
    require("gruvbox").setup({
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
  end
  , opts = ...}
  --{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
}
