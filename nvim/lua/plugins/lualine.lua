local lsp_names = function()
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    return ''
  end

  local names = {}
  for _, client in ipairs(clients) do
    if client.name ~= 'null-ls' then
      table.insert(names, client.name)
    end
  end

  return table.concat(names, ', ')
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    {
      'nvim-tree/nvim-web-devicons',
      lazy = true,
    },
  },
  opts = {
    options = {
      theme = 'auto',
      -- component_separators = { left = '', right = '' },
      component_separators = { left = '󰇙', right = '󰇙' },
      section_separators = { left = '', right = '' },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      -- lualine_y = { 'progress' },
      -- lualine_z = { 'location' },
      lualine_y = { lsp_names },
      lualine_z = { 'location', 'progress' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
  },
}
