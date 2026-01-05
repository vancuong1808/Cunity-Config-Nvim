return {
  -- csharp-ls / csharp-language-server (fallback option for C#)
  -- We do NOT enable it by default to avoid double-attaching with Roslyn.
  -- Note: not auto-installed via Mason because upstream dotnet tool packaging
  -- has been flaky; keep this as an optional manual fallback.
  "neovim/nvim-lspconfig",
  ft = { "cs" },
  config = function()
    local lsp_common = require("helpers.lsp-common")

    vim.lsp.config("csharp_ls", {
      capabilities = lsp_common.capabilities(),
      on_attach = lsp_common.on_attach(),
    })

    if vim.g.csharp_lsp_choice == "csharp_ls" then
      vim.lsp.enable("csharp_ls")
    end
  end,
}
