return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install({
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
        'json',
        'yaml',
        'markdown',
        'markdown_inline',
      })

      -- highlight
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- folding
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldenable = false
        end,
      })

      -- indent
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.bo.indentexpr = 'v:lua.require\'nvim-treesitter\'.indentexpr()'
        end,
      })
    end,
  },
}
