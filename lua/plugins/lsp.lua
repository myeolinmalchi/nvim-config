return {
  -- lazydev (replaces neodev)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    priority = 49,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()

      local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
      }

      local lspconfig = require('lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.pyright.setup {
        capabilities = capabilities,
      }

      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.astro.setup {
        capabilities = capabilities,
      }

      lspconfig.eslint.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = bufnr,
            command = "EslintFixAll"
          })
        end
      }

      lspconfig.html.setup {
        capabilities = capabilities,
      }

      lspconfig.cssls.setup {
        capabilities = capabilities,
      }

      lspconfig.cssmodules_ls.setup {}

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
      }

      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        filetypes = {
          "css", "eruby", "html", "javascript", "javascriptreact",
          "less", "sass", "scss", "svelte", "pug",
          "typescript", "typescriptreact", "vue", "astro",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          local options = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, options)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, options)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, options)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, options)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, options)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, options)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, options)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, options)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, options)
        end,
      })
    end
  },

  -- conform.nvim (formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        astro = { "prettier" },
        python = { "yapf" },
        lua = { "stylua" },
      },
      format_on_save = {
        timeout_ms = 3000,
        lsp_fallback = true,
      },
    },
  },

  -- nvim-lint
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        astro = { "eslint_d" },
      }
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
