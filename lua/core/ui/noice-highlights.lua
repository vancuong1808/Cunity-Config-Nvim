local function setup()
  local set = vim.api.nvim_set_hl

  -- === Notify ===
  set(0, "NotifyBackground", { link = "Pmenu" })
  set(0, "NotifyINFOBody",   { link = "Normal" })
  set(0, "NotifyINFOTitle",  { link = "Title" })

  set(0, "NotifyWARNBody",   { link = "WarningMsg" })
  set(0, "NotifyERRORBody",  { link = "ErrorMsg" })

  -- === Noice LSP progress ===
  set(0, "NoiceLspProgressTitle",   { link = "Title" })
  set(0, "NoiceLspProgressClient",  { link = "Comment" })
  set(0, "NoiceLspProgressSpinner", { link = "Special" })
  set(0, "NoiceLspProgress",        { link = "Normal" })
end

-- reapply when theme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = setup,
})

setup()
