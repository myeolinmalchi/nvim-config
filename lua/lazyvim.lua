local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  --'preservim/nerdtree', 
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      {'nvim-tree/nvim-web-devicons', opt = true }
    }
  }, 
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },


  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}, 
  'HerringtonDarkholme/yats.vim', 
  'maxmellon/vim-jsx-pretty', 
  'nanotech/jellybeans.vim', 
  --'Xuyuanp/nerdtree-git-plugin', 

  --'alvan/vim-closetag', 
  'mattn/emmet-vim', 

  'jeetsukumaran/vim-buffergator', 
  'ryanoasis/vim-devicons', 
  'chriskempson/base16-vim', 
  'Raimondi/delimitMate', 

  'ctrlpvim/ctrlp.vim', 
  'itchyny/vim-cursorword', 

  --'preservim/nerdcommenter', 
  'prisma/vim-prisma', 
  'vim-scripts/LargeFile', 
  'tpope/vim-fugitive',
  'RRethy/nvim-base16',

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  }, 

  'jose-elias-alvarez/null-ls.nvim', 
  'MunifTanjim/prettier.nvim', 

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }, 
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

{
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
        view = {
          width = 40, 
        }, 
      renderer = {
        group_empty = true
      }, 
      filters = {
        dotfiles = true
      }
    }
  end,
}, 



  --{
  --  'prettier/vim-prettier', 
  --  run = 'yarn install --frozen-lockfile --production'
  --},
  'preservim/tagbar', 
  {
    'akinsho/toggleterm.nvim', 
    tag = '*'
  },
  {
    'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate'
  },
  'lukas-reineke/indent-blankline.nvim', 

  {
    -- LSP Configuration & ins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer', 
      'hrsh7th/cmp-path', 
      'hrsh7th/cmp-cmdline',
      'hrsh7th/vim-vsnip', 
      'hrsh7th/cmp-vsnip'
    },
  },
})
