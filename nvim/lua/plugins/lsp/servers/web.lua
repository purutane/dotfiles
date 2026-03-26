local M = {}

function M.setup(capabilities)
  -- ts_ls (typescript, javascript)
  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', '.git'),
    filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    settings = {
      typescript = {
        format = {
          enable = true,
        },
      },
    },
  })
  vim.lsp.enable('ts_ls')

  -- astro
  vim.lsp.config('astro', {
    capabilities = capabilities,
    filetypes = { 'astro' },
    init_options = {
      settings = {
        typescript = {
          tsdk = vim.fn.stdpath('data') .. '/mason/packages/typescript-language-server/node_modules/typescript/lib',
        },
      },
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  })
  vim.lsp.enable('astro')

  -- html
  vim.lsp.config('html', {
    capabilities = capabilities,
    filetypes = { 'html' },
    init_options = {
      configurationSection = {
        'html',
        'css',
        'javascript',
      },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
    },
  })
  vim.lsp.enable('html')

  -- cssls
  vim.lsp.config('cssls', {
    capabilities = capabilities,
    filetypes = { 'css', 'scss', 'sass', 'less' },
    settings = {
      css = {
        validate = true,
        lint = {
          unknownAtRules = 'ignore',
        },
      },
    },
  })
  vim.lsp.enable('cssls')
end

return M
