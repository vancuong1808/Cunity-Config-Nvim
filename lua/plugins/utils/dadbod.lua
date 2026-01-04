return {
  "tpope/vim-dadbod",
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  cmd = {
    "DB",
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = {
    -- Keep <leader>ud for Dashboard; use a 3-keystroke mapping for DBUI.
    { "<leader>udb", "<cmd>DBUIToggle<cr>", desc = "DB UI" },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
