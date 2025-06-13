return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-lua/plenary.nvim',
        lazy = true,
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
      },
      {
        'nvim-tree/nvim-web-devicons',
        lazy = true,
      },
      {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        lazy = true,
      },
      {
        'folke/tokyonight.nvim',
      },
    },
    cmd = { 'Telescope' },
    keys = {
      {
        '<leader>ff',
        function()
          require('telescope.builtin').find_files()
        end,
        desc = 'Find files',
      },
      {
        '<leader>fg',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'live grep',
      },
      {
        '<leader>fb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Find Buffers',
      },
      {
        '<leader>fh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'Help tags',
      },
      {
        '<leader>fr',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = 'Recent files',
      },
      {
        '<leader>fc',
        function()
          require('telescope.builtin').current_buffer_fuzzy_find()
        end,
        desc = 'Find in current buffer',
      },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')

      local setup_highlights = function()
        -- colors from colorschme
        local colors = require('tokyonight.colors').setup({ style = 'storm' })
        local bg = colors.bg
        local fg = colors.fg

        -- set highlight groups
        vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = bg, fg = fg })
        vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = bg, fg = colors.blue5 })
        vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { bg = bg })
        vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = bg, fg = colors.blue5 })
        vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = colors.blue5, fg = colors.bg_dark })
        vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = colors.green, fg = colors.bg_dark })
        vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = colors.purple, fg = colors.bg_dark })
      end

      telescope.setup({
        defaults = {
          path_display = { 'truncate' },
          layout_strategy = 'horizontal',
          layout_config = {
            width = 0.95,
            preview_width = 0.6,
            horizontal = {
              prompt_position = 'bottom',
            },
          },
          prompt_prefix = ' 󰍉 ',
          selection_caret = ' 󰄾 ',
          entry_prefix = '  ',
          color_devicons = true,
          mappings = {
            i = {
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
              ['<Esc>'] = actions.close,
              ['<C-d>'] = function()
                local entry = action_state.get_selected_entry()
                if not entry or not entry.bufnr then
                  return
                end
                vim.api.nvim_buf_delete(entry.bufnr, { force = true })
                require('telescope.builtin').buffers()
              end,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          live_grep = {
            additional_args = function()
              return { '--hidden', '--no-ignore' }
            end,
          },
        },
      })

      telescope.load_extension('fzf')

      setup_highlights()
    end,
  },
}
