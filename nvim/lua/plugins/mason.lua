return {
  {
    'mason-org/mason.nvim',
    -- cmd = {
    --   'Mason',
    --   'MasonInstall',
    --   'MasonUninstall',
    --   'MasonUninstallAll',
    --   'MasonLog',
    --   'MasonUpdate',
    --   'MasonUpdateAll',
    -- },
    event = 'VeryLazy',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'prettier',
      },
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        -- lua
        'lua_ls',
        -- python
        'pyright',
        'ruff',
        -- bash
        'bashls',
        -- terraform
        'terraformls',
        'tflint',
        -- astro
        'astro',
        'ts_ls',
        'html',
        'cssls',
        -- json
        'jsonls',
      },
      automatic_installation = true,
      automatic_enable = {
        exclude = {
          -- lua - handled by nvim-lspconfig
          'lua_ls',
          -- python - handled by nvim-lspconfig
          'pyright',
          'ruff',
          -- bash - handled by nvim-lspconfig
          'bashls',
          -- terraform - handled by nvim-lspconfig
          'terraformls',
          'tflint',
          -- astro - handled by nvim-lspconfig
          'astro',
          'ts_ls',
          'html',
          'cssls',
          -- json - handled by nvim-lspconfig
          'jsonls',
        },
      },
    },
  },
}
