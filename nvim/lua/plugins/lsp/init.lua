return {
  {
    'neovim/nvim-lspconfig',
    enabled = true,
    cmd = {
      'LspInfo',
      'LspInstall',
      'LspUninstall',
      'LspStart',
      'LspStop',
      'LspRestart',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
    },
    config = function()
      -- Common setup
      require('plugins.lsp.keymaps').setup()
      require('plugins.lsp.diagnostics').setup()

      -- Get capabilities once
      local capabilities = require('plugins.lsp.capabilities').get()

      -- Server configurations
      require('plugins.lsp.servers.lua').setup(capabilities)
      require('plugins.lsp.servers.terraform').setup(capabilities)
      require('plugins.lsp.servers.web').setup(capabilities)
      require('plugins.lsp.servers.bash').setup(capabilities)
      require('plugins.lsp.servers.python').setup(capabilities)
    end,
  },
}
