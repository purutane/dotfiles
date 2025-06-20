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
      {
        'windwp/nvim-ts-autotag',
        lazy = true,
      },
    },
    config = function()
      -- treesitter configuration
      require('nvim-treesitter.configs').setup({
        -- language parser
        ensure_installed = {
          'lua',
          'python',
          'terraform',
          'hcl',
          'astro',
          'tsx',
          'typescript',
          'javascript',
          'html',
          'css',
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
        -- auttag configuration
        require('nvim-ts-autotag').setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
          },
        }),
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
