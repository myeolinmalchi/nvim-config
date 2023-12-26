require("tokyonight").setup({
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
})
