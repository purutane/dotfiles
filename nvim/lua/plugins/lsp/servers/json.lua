local M = {}

function M.setup(capabilities)
  vim.lsp.config('jsonls', {
    capabilities = capabilities,
    filetypes = { 'json', 'jsonc' },
    settings = {
      schemas = require('schemastore').json.schemas(),
      json = {
        validate = { enable = true },
      },
    },
  })
  vim.lsp.enable('jsonls')
end

return M
