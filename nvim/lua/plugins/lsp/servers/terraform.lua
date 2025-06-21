local M = {}

function M.setup(capabilities)
  local lspconfig = require('lspconfig')

  local function get_root_dir(fname)
    local util = require('lspconfig.util')
    local root = util.root_pattern('.terraform', '*.tf')(fname)
    if root then
      return root
    end
    return vim.fn.getcwd()
  end

  -- terraform-ls
  lspconfig.terraformls.setup({
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

  -- tflint
  lspconfig.tflint.setup({
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
end

return M
