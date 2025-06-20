return {
  'greggh/claude-code.nvim',
  -- event = 'VeryLazy',
  cmd = 'ClaudeCode',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude Code' })
  end,
  config = function()
    require('claude-code').setup()
  end,
}
