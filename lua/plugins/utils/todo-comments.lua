return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  keys = {
    { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    { "<leader>tT", "<cmd>TodoTrouble<cr>", desc = "TODOs (Trouble)" },
  },
  opts = {},
}
