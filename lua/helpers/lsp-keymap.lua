local M = {}

function M.on_attach(_, bufnr)
  local map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
  end

  local tb = require("telescope.builtin")

  -- Navigation
  map("gd", tb.lsp_definitions, "LSP: Definitions")
  map("gD", tb.lsp_type_definitions, "LSP: Type Definitions")
  map("gr", tb.lsp_references, "LSP: References")
  map("gi", tb.lsp_implementations, "LSP: Implementations")

  -- Symbols
  map("<leader>ss", tb.lsp_document_symbols, "Symbols (document)")
  map("<leader>sS", tb.lsp_workspace_symbols, "Symbols (workspace)")

  -- Diagnostics
  map("<leader>sd", tb.diagnostics, "Diagnostics")

  -- Call hierarchy
  map("<leader>si", tb.lsp_incoming_calls, "Incoming calls")
  map("<leader>so", tb.lsp_outgoing_calls, "Outgoing calls")
end

return M
