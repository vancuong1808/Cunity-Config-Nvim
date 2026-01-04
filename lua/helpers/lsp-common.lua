local M = {}

function M.capabilities()
  local ok, blink = pcall(require, "blink.cmp")
  if ok and blink.get_lsp_capabilities then
    return blink.get_lsp_capabilities()
  end

  return vim.lsp.protocol.make_client_capabilities()
end

function M.on_attach()
  local navic_ok, navic = pcall(require, "nvim-navic")

  return function(client, bufnr)
    local ok, keymaps = pcall(require, "helpers.lsp-keymaps")
    if ok then
      keymaps.on_attach(client, bufnr)
    end

    if navic_ok and client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end
end

return M
