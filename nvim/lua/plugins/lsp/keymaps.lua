local M = {}

function M.setup()
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(ev)
      local opts = { buffer = ev.buf, noremap = true, silent = true }
      -- Navigation
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
      -- Documentation
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, opts)
      -- Code actions
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<leader>f', function()
        -- Format logic
        local filetype = vim.bo.filetype
        if filetype == 'astro' then
          vim.lsp.buf.format({
            async = true,
            filter = function(client)
              return client.name == 'null-ls'
            end,
          })
        else
          vim.lsp.buf.format({ async = true })
        end
      end, opts)
      -- Workspace
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      -- Diagnostics
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, opts)
      vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
    end,
  })
end

return M
