local M = {}

function M.get()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  return capabilities
end

return M
