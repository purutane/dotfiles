local M = {}

function M.setup(capabilities)
  vim.lsp.config('yamlls', {
    capabilities = capabilities,
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' }, -- SchemaStore.nvim に任せる
        schemas = require('schemastore').yaml.schemas(),
        validate = true,
        completion = true,
        hover = true,
      },
    },
  })
  vim.lsp.enable('yamlls')
end

return M
