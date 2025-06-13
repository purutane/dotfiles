return {
  'github/copilot.vim',
  keys = {
    { '<A-j>', mode = 'i', desc = 'Accept Copilot suggestion' },
    { '<A-l>', mode = 'i', desc = 'Accept Copilot line' },
    { '<A-w>', mode = 'i', desc = 'Accept Copilot word' },
    { '<A-p>', mode = 'i', desc = 'Previous Copilot suggestion' },
    { '<A-n>', mode = 'i', desc = 'Next Copilot suggestion' },
  },
  cmd = {
    'Copilot',
    'CopilotEnable',
    'CopilotDisable',
    'CopilotStatus',
  },
  event = 'BufReadPost',
  init = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ''

    vim.g.copilot_filetypes = {
      ['*'] = true,
      ['help'] = false,
      ['gitcommit'] = false,
      ['TelescopePrompt'] = false,
    }
  end,
  config = function()
    vim.api.nvim_set_keymap('i', '<A-j>', 'copilot#Accept()', { silent = true, expr = true })
    vim.api.nvim_set_keymap('i', '<A-l>', 'copilot#AcceptLine()', { silent = true, expr = true })
    vim.api.nvim_set_keymap('i', '<A-w>', 'copilot#AcceptWord()', { silent = true, expr = true })
    vim.api.nvim_set_keymap('i', '<A-p>', 'copilot#Previous()', { silent = true, expr = true })
    vim.api.nvim_set_keymap('i', '<A-n>', 'copilot#Next()', { silent = true, expr = true })
  end,
}
