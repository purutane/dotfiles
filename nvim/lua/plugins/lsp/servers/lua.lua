local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.stdpath('config') .. '/lua',
          },
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })
end

return M
