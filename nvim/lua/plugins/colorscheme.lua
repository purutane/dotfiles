return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      on_colors = function(colors)
        -- winseparators
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.fg_gutter, bg = 'none' })
        -- float
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = colors.bg })
        vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.blue5, bg = colors.bg })
        -- completion
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { strikethrough = true, fg = colors.fg_dark, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = colors.blue, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { fg = colors.blue, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { fg = colors.purple, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { fg = colors.purple, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { fg = colors.blue, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { fg = colors.cyan, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindText', { fg = colors.green, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindStruct', { fg = colors.orange, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindClass', { fg = colors.yellow, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { fg = colors.yellow, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindModule', { fg = colors.yellow, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { fg = colors.blue, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { fg = colors.green, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindValue', { fg = colors.orange, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindEnum', { fg = colors.orange, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindConstant', { fg = colors.orange, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindSnippet', { fg = colors.magenta, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFile', { fg = colors.blue5, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpItemKindFolder', { fg = colors.blue5, bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'CmpDocumentation', { fg = colors.fg, bg = colors.bg_dark })
        vim.api.nvim_set_hl(0, 'CmpDocumentationBorder', { fg = colors.blue5, bg = colors.bg_dark })
      end,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd.colorscheme('tokyonight')
    end,
  },
}
