local M = {}

local function set_choice(choice)
  vim.g.csharp_lsp_choice = choice
  vim.notify(
    "C# LSP set to '" .. choice .. "'. Restart Neovim (recommended) to apply.",
    vim.log.levels.INFO
  )
end

function M.setup_commands()
  vim.api.nvim_create_user_command("CSharpUseRoslyn", function()
    set_choice("roslyn")
  end, { desc = "Use Roslyn for C# (recommended)" })

  vim.api.nvim_create_user_command("CSharpUseCsharpLs", function()
    set_choice("csharp_ls")
  end, { desc = "Use csharp-ls for C# (fallback)" })

  vim.api.nvim_create_user_command("CSharpLsp", function()
    local choice = vim.g.csharp_lsp_choice or "roslyn"
    vim.notify("Current C# LSP choice: " .. choice, vim.log.levels.INFO)
  end, { desc = "Show current C# LSP choice" })
end

return M
