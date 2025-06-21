local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  -- ts_ls (typescript, javascript)
  lspconfig.ts_ls.setup({
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

  -- astro
  lspconfig.astro.setup({
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

  -- html
  lspconfig.html.setup({
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

  -- cssls
  lspconfig.cssls.setup({
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
end

return M
