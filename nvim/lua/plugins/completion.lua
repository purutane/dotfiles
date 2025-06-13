return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- load vscode style snippets
      require('luasnip.loaders.from_vscode').lazy_load({
        paths = { vim.fn.stdpath('config') .. '/snippets' },
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            winhighlight = 'Normal:Pmenu,FloatBorder:CmpDocumentationBorder,CursorLine:PmenuSel,Search:None',
            scrollbar = '║',
            side_padding = 1,
          },
          documentation = {
            border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
            winhighlight = 'Normal:CmpDocumentation,FloatBorder:CmpDocumentationBorder',
            max_height = 20,
            min_width = 80,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              fallback()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'luasnip', priority = 750 },
        }, {
          { name = 'buffer', priority = 500 },
          { name = 'path', priority = 250 },
        }),

        formatting = {
          format = function(entry, vim_item)
            local kind_icons = {
              Text = '',
              Method = '󰆧',
              Function = '󰊕',
              Constructor = '',
              Field = '󰇽',
              Variable = '󰂡',
              Class = '󰠱',
              Interface = '',
              Module = '',
              Property = '󰜢',
              Unit = '',
              Value = '󰎠',
              Enum = '',
              Keyword = '󰌋',
              Snippet = '',
              Color = '󰏘',
              File = '󰈙',
              Reference = '',
              Folder = '󰉋',
              EnumMember = '',
              Constant = '󰏿',
              Struct = '',
              Event = '',
              Operator = '󰆕',
              TypeParameter = '󰅲',
            }
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)

            vim_item.menu = ({
              nvim_lsp = '󰌵 LSP',
              luasnip = '󰂺 Snippet',
              buffer = '󰓩 Buffer',
              path = '󰉋 Path',
            })[entry.source.name]

            return vim_item
          end,
        },
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
    end,
  },
}
