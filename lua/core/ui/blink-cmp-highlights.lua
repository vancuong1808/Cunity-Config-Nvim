local hl = vim.api.nvim_set_hl

local function apply()
  -- Base (theo theme)
  hl(0, "BlinkCmpMenu", { link = "Pmenu" })
  hl(0, "BlinkCmpMenuBorder", { link = "FloatBorder" })
  hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })

  hl(0, "BlinkCmpLabel", { link = "Normal" })
  hl(0, "BlinkCmpLabelDetail", { link = "Comment" })
  hl(0, "BlinkCmpLabelDescription", { link = "Comment" })
  hl(0, "BlinkCmpSource", { link = "Comment" })

  hl(0, "BlinkCmpGhostText", { link = "NonText" })

  hl(0, "BlinkCmpDoc", { link = "NormalFloat" })
  hl(0, "BlinkCmpDocBorder", { link = "FloatBorder" })

  -- Accent (có kiểm soát – vẫn theo theme)
  hl(0, "BlinkCmpKindFunction", { link = "Function" })
  hl(0, "BlinkCmpKindMethod", { link = "Function" })
  hl(0, "BlinkCmpKindVariable", { link = "Identifier" })
  hl(0, "BlinkCmpKindClass", { link = "Type" })
  hl(0, "BlinkCmpKindInterface", { link = "Type" })
  hl(0, "BlinkCmpKindModule", { link = "Include" })

  -- Deprecated
  hl(0, "BlinkCmpLabelDeprecated", { link = "DiagnosticDeprecated" })

  -- Signature
  hl(0, "BlinkCmpSignatureHelp", { link = "NormalFloat" })
  hl(0, "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" })
  hl(0, "BlinkCmpSignatureHelpActiveParameter", { link = "LspSignatureActiveParameter" })
end

apply()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply,
})
