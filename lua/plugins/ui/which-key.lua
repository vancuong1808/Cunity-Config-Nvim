return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    win = {
      border = "rounded",
      padding = { 1, 2 },
      wo = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    
    -- Register group names
    wk.add({
      { "<leader>f", group = "Find/Files" },
      { "<leader>c", group = "Cheatsheets" },
      { "<leader>e", group = "Explorer" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Hunk" },
      { "<leader>l", group = "LSP" },
      { "<leader>m", group = ".NET" },
      { "<leader>t", group = "Toggle" },
      { "<leader>u", group = "UI/Utils" },
      { "<leader>n", group = "Notify/Noice" },
      { "<leader>j", group = "Jump" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>x", group = "Trouble" },
      { "<leader>y", group = "Yazi" },
      { "<leader>p", group = "Project" },
      { "b", group = "Buffer" },
    })
  end,
}
