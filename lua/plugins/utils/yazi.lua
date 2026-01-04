return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>y", function() require("yazi").yazi() end, desc = "Yazi" },
    { "<leader>Y", function() require("yazi").yazi({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Yazi (cwd=file)" },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = "g?",
    },
  },
}
