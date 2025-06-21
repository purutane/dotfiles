local M = {}
local original_handler = vim.lsp.handlers['textDocument/publishDiagnostics']

function M.setup()
  -- global handler (set diagnostic source)
  vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local client_name = client and client.name or 'unknown'

    for _, diagnostic in ipairs(result.diagnostics) do
      if not diagnostic.source or diagnostic.source == '' then
        diagnostic.source = client_name
      end
    end
    original_handler(err, result, ctx, config)
  end
  -- vim.diagnostic
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = ' ',
        [vim.diagnostic.severity.WARN] = ' ',
        [vim.diagnostic.severity.INFO] = ' ',
        [vim.diagnostic.severity.HINT] = ' ',
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.INFO] = '',
        [vim.diagnostic.severity.HINT] = '',
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = true,
      format = function(diagnostic)
        return string.format('%s (%s)', diagnostic.message, diagnostic.source)
      end,
      winhighlight = 'NormalFloat:NormalFloat,Border:FloatBorder',
    },
  })
end

return M
