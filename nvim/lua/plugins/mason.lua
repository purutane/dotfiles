return {
  {
    'mason-org/mason.nvim',
    -- cmd = {
    --   'Mason',
    --   'MasonInstall',
    --   'MasonUninstall',
    --   'MasonUninstallAll',
    --   'MasonLog',
    --   'MasonUpdate',
    --   'MasonUpdateAll',
    -- },
    event = 'VeryLazy',
    build = ':MasonUpdate',
    opts = {
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        -- lua
        'lua_ls',
        -- python
        'pyright',
        'ruff',
        -- bash
        'bashls',
        -- terraform
        'terraformls',
        -- astro
        'astro',
        'ts_ls',
        'html',
        'cssls',
      },
      automatic_installation = true,
      automatic_enable = {
        exclude = {
          -- lua - handled by nvim-lspconfig
          'lua_ls',
          -- python - handled by nvim-lspconfig
          'pyright',
          'ruff',
          -- bash - handled by nvim-lspconfig
          'bashls',
          -- terraform - handled by nvim-lspconfig
          'terraformls',
          'tflint',
          -- astro - handled by nvim-lspconfig
          'astro',
          'ts_ls',
          'html',
          'cssls',
        },
      },
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    -- event = { 'BufReadPre', 'BufNewFile' },
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
    opts = {
      ensure_installed = {
        -- lua
        'stylua',
        -- bash
        'shellcheck',
        -- terraform
        'terraform_fmt',
        -- astro/frontend
        'prettier',
      },
      automatic_installation = true,
    },
  },
  {
    'nvimtools/none-ls.nvim',
    -- event = { 'BufReadPre', 'BufNewFile' },
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local null_ls = require('null-ls')

      local augroup = vim.api.nvim_create_augroup('LSPFormatting', { clear = true })

      null_ls.setup({
        sources = {
          -- lua
          null_ls.builtins.formatting.stylua.with({
            extra_args = {
              '--quote-style',
              'ForceSingle',
              '--indent-type',
              'Spaces',
              '--indent-width',
              '2',
            },
          }),
          -- terraform
          null_ls.builtins.formatting.terraform_fmt,
          -- prettier for astro and web files
          null_ls.builtins.formatting.prettier.with({
            filetypes = {
              'astro',
              'json',
              'yaml',
              'markdown',
            },
            prefer_local = 'node_modules/.bin',
          }),
        },

        on_attach = function(client, bufnr)
          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              group = augroup,
              callback = function()
                vim.lsp.buf.format({
                  bufnr = bufnr,
                  filter = function(c)
                    return c.name == 'null-ls'
                  end,
                  timeout_ms = 2000,
                })
              end,
            })
          end
        end,
      })

      local function setup_stylua_config()
        local config_path = vim.fn.stdpath('config') .. '/.stylua.toml'

        if vim.fn.filereadable(config_path) == 0 then
          local file = io.open(config_path, 'w')
          if file then
            file:write([[
column_width = 120
line_endings = "Unix"
indent_type = "Spaces"
indent_width = 2
quote_style = "ForceSingle"
call_parentheses = "Always"
]])
            file:close()
            print('Created .stylua.toml at' .. config_path)
          end
        end
      end

      setup_stylua_config()
    end,
  },
}
