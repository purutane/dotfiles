local M = {}

function M.setup()
  -- terraform
  vim.filetype.add({
    extension = {
      tf = 'terraform',
      tfvars = 'terraform-vars',
    },
  })
  -- astro
  vim.filetype.add({
    extension = {
      astro = 'astro',
    },
  })
end

return M
