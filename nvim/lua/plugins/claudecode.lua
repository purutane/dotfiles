return {
  'coder/claudecode.nvim',
  cmd = { 'ClaudeCode', 'ClaudeCodeFocus', 'ClaudeCodeSend', 'ClaudeCodeAdd' },
  opts = {
    terminal = {
      provider = 'native',
    },
  },
  keys = {
    { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude Code' },
    { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude Code' },
    { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude Code' },
    { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer to Claude' },
  },
}
