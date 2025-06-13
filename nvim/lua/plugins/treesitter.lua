return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = {
      'TSInstall',
      'TSUninstall',
      'TSUpdate',
      'TSUpdateSync',
      'TSInstallInfo',
      'TSInstallSync',
      'TSInstallFromGrammar',
    },
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        lazy = true,
      },
    },
    config = function()
      local configs = require('nvim-treesitter.configs')
      configs.setup({
        -- language parser
        ensure_installed = {
          'lua',
          'python',
          'terraform',
          'hcl',
        },

        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = true },

        textobjects = {
          subject = {
            enable = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',
            },
          },
        },
      })

      -- folding settings
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

      -- disable folding by default
      vim.opt.foldenable = false
      vim.opt.foldlevel = 99
    end,
  },
}
