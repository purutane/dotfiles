local M = {}

function M.setup(capabilities)
  local function get_root_dir(bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local util = require('lspconfig.util')
    local root = util.root_pattern('.terraform', '*.tf')(fname)
    if root then
      return root
    end
    return vim.fn.getcwd()
  end

  -- terraform-ls
  vim.lsp.config('terraformls', {
    capabilities = capabilities,
    root_dir = get_root_dir,
    filetypes = { 'terraform', 'terraform-vars', 'hcl' },
    cmd = { 'terraform-ls', 'serve' },
    settings = {
      terraform = {
        experimentalFeatures = {
          validateOnSave = true,
          prefillRequiredFields = true,
        },
      },
    },
    on_attach = function(client)
      client.server_capabilities.documentHighlightProvider = false
    end,
  })
  vim.lsp.enable('terraformls')

  -- tflint
  vim.lsp.config('tflint', {
    capabilities = capabilities,
    root_dir = get_root_dir,
    filetypes = { 'terraform', 'terraform-vars', 'hcl' },
    cmd = { 'tflint', '--langserver' },
    on_attach = function(client)
      local original_capabilities = client.server_capabilities
      for capability, _ in pairs(original_capabilities) do
        if capability ~= 'textDocumentSync' then
          original_capabilities[capability] = false
        end
      end
    end,
  })
  vim.lsp.enable('tflint')
end

return M
