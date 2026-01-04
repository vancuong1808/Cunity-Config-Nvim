vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("redraw")
  end,
})
