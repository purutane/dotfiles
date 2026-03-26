local M = {}

function M.setup(capabilities)
  -- bashls
  vim.lsp.config('bashls', {
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
  vim.lsp.enable('bashls')
end

return M
