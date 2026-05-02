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
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'stylua',
        'shellcheck',
        'prettierd',
      },
      auto_update = false,
      run_on_start = true,
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
        -- yaml
        'yamlls',
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
          -- yaml - handled by nvim-lspconfig
          'yamlls',
        },
      },
    },
  },
}
