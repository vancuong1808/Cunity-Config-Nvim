local function apply_terminal_transparency()
  -- Allow terminal transparency (WezTerm Acrylic/Mica, opacity) to show through.
  -- Neovide has its own opacity pipeline, so keep this for terminal UIs.
  if vim.g.neovide then
    return
  end

  local transparent_groups = {
    "Normal",
    "NormalNC",
    "EndOfBuffer",
    "SignColumn",
    "MsgArea",
    "LineNr",
    "CursorLineNr",
    "FoldColumn",
    "WinSeparator",
    "VertSplit",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "NormalFloat",
    "FloatBorder",
    "Pmenu",
    "PmenuSel",
  }
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    apply_terminal_transparency()
    vim.cmd("redraw")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    apply_terminal_transparency()
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if vim.bo.filetype == "alpha" then
      local ok, alpha = pcall(require, "alpha")
      if ok and alpha and alpha.redraw then
        pcall(alpha.redraw)
      end
    end
  end,
})
