local IME_ASCII = 'com.apple.keylayout.ABC'
-- local IME_JAPANESE = 'com.google.inputmethod.Japanese.base'
local IME_JAPANESE = 'com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese'

local function has_im_select()
  return vim.fn.executable('im-select') == 1
end

local function switch_ime(ime_id)
  if has_im_select() then
    vim.fn.system('im-select ' .. ime_id)
  end
end

local function to_ascii()
  switch_ime(IME_ASCII)
end

local function to_hiragana()
  switch_ime(IME_JAPANESE)
end

if has_im_select() then
  local ime_augroup = vim.api.nvim_create_augroup('IMEControl', { clear = true })

  vim.api.nvim_create_autocmd('InsertLeave', {
    group = ime_augroup,
    pattern = '*',
    callback = to_ascii,
  })
end
