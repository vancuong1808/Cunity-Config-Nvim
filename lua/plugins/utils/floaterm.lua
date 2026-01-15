return {
  "voldikss/vim-floaterm",
  keys = {
    { "<F12>", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm", mode = "n" },
    { "<F11>", "<cmd>FloatermNew<cr>", desc = "New Floaterm", mode = "n" },
    { "<F10>", "<cmd>FloatermKill<cr>", desc = "Kill Floaterm", mode = "n" },

    -- When inside terminal-mode, exit to normal-mode first
    { "<F12>", [[<C-\><C-n><cmd>FloatermToggle<cr>]], desc = "Toggle Floaterm", mode = "t" },
    { "<F11>", [[<C-\><C-n><cmd>FloatermNew<cr>]], desc = "New Floaterm", mode = "t" },
    { "<F10>", [[<C-\><C-n><cmd>FloatermKill<cr>]], desc = "Kill Floaterm", mode = "t" },
  },
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8

    -- Prefer PowerShell (pwsh) on Windows.
    if vim.fn.has("win32") == 1 then
      if vim.fn.executable("pwsh") == 1 then
        vim.g.floaterm_shell = "pwsh"
      elseif vim.fn.executable("pwsh.exe") == 1 then
        vim.g.floaterm_shell = "pwsh.exe"
      elseif vim.fn.executable("powershell") == 1 then
        vim.g.floaterm_shell = "powershell"
      elseif vim.fn.executable("powershell.exe") == 1 then
        vim.g.floaterm_shell = "powershell.exe"
      end
    end

    vim.g.floaterm_wintype = "float"
    vim.g.floaterm_position = "center"
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_autohide = 1
  end,
}
