local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')
  -- bashls
  lspconfig.bashls.setup({
    capabilities = capabilities,
    root_dir = function(fname)
      return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
    end,
    filetypes = { 'sh', 'bash', 'zsh' },
    settings = {
      bashIde = {
        globPattern = {
          '**/*.sh',
          '**/*.bash',
          '**/*.zsh',
        },
        enableSourceErrorDiagnostics = true,
        shellcheckPath = '',
        shellcheckArgs = {},
        includeAllWorkspaceSymbols = true,
      },
    },
  })
end

return M
