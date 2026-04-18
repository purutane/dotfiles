return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ComformInfo' },
  config = function()
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        terraform = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        hcl = { 'terraform_fmt' },
        astro = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
      },
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
    })
  end,
}
