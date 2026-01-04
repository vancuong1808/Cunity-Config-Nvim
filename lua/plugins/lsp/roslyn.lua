return {
  "seblyng/roslyn.nvim",
  ft = { "cs", "razor" },
  init = function()
    vim.filetype.add({
      extension = {
        razor = "razor",
        cshtml = "razor",
      },
    })
  end,
  dependencies = {
    "neovim/nvim-lspconfig",
  },
  opts = {
    -- Enable searching parent dirs for *.sln when repo layout is wide
    broad_search = true,
  },
  config = function(_, opts)
    local lsp_common = require("helpers.lsp-common")

    require("roslyn").setup(opts)

    vim.lsp.config("roslyn", {
      capabilities = lsp_common.capabilities(),
      on_attach = lsp_common.on_attach(),
      settings = {
        ["csharp|background_analysis"] = {
          -- Keep diagnostics responsive on big solutions
          dotnet_analyzer_diagnostics_scope = "openFiles",
          dotnet_compiler_diagnostics_scope = "openFiles",
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = true,
          dotnet_enable_tests_code_lens = true,
        },
        ["csharp|formatting"] = {
          -- We format with csharpier (conform.nvim); keep Roslyn from re-sorting unexpectedly
          dotnet_organize_imports_on_format = false,
        },
      },
    })

    vim.lsp.enable("roslyn")

    -- Refresh codelens when relevant (Roslyn supports it, but you must refresh).
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
      pattern = { "*.cs", "*.razor", "*.cshtml" },
      callback = function()
        pcall(vim.lsp.codelens.refresh)
      end,
    })
  end,
}
