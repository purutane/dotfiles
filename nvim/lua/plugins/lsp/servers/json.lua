local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  lspconfig.jsonls.setup({
    capabilities = capabilities,
    filetypes = { 'json', 'jsonc' },
    settings = {
      schemas = require('schemastore').json.schemas(),
      json = {
        validate = { enable = true },
      },
    },
  })
end

return M
