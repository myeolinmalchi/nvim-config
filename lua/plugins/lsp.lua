return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim",  opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    priority = 49,
    config = function(_, opts)
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

      -- LSP settings (for overriding per client)
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }

      local lspconfig = require('lspconfig')
      --local configs = require('lspconfig/configs')
      --local capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.pyright.setup {
        --handlers = handlers,
        capabilities = capabilities,
      }

      lspconfig.ts_ls.setup {
        --handlers = handlers,
        capabilities = capabilities,
      }

      lspconfig.astro.setup {
        --handlers = handlers,
        capabilities = capabilities,
      }


      lspconfig.eslint.setup {
        --handlers = handlers,
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
        --handlers = handlers,
        capabilities = capabilities,
      }

      lspconfig.tailwindcss.setup {
        --handlers = handlers,
        capabilities = capabilities,
      }

      lspconfig.emmet_ls.setup({
        --handlers = handlers,
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "sass",
          "scss",
          "svelte",
          "pug",
          "typescript",
          "typescriptreact",
          "vue",
          "astro", 
        },
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              ["bem.enabled"] = true,
            },
          },
        }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local options = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, options)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, options)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, options)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, options)
          --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, options)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, options)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, options)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, options)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, options)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, options)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, options)
          --[[
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, options)
          ]]--
        end,
      })
    end
  },

  -- null-ls
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
      local event = "BufWritePre" -- or "BufWritePost"
      local async = event == "BufWritePost"

      return {
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- format on save
            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            vim.api.nvim_create_autocmd(event, {
              buffer = bufnr,
              group = group,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr, async = async })
              end,
              desc = "[lsp] format on save",
            })
          end

          if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
              vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
          end
        end,
      }
    end,
  },

  -- eslint
  {
    "MunifTanjim/eslint.nvim",
    opts = {
      bin = 'eslint',
      code_actions = {
        enable = true,
        apply_on_save = {
          enable = true,
          types = { "directive", "problem", "suggestion", "layout" },
        },
        disable_rule_comment = {
          enable = true,
          location = "separate_line", -- or `same_line`
        },
      },
      diagnostics = {
        enable = true,
        report_unused_disable_directives = false,
        run_on = "type", -- or `save`
      },
    },
  },

  -- prettier
  {
    "MunifTanjim/prettier.nvim",
    opts = {
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "astro",
        "lua",
      },
    }
  }
}
