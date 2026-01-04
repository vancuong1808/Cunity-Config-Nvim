return {
  "echasnovski/mini.diff",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    view = {
      style = 'sign',
      signs = { add = '│', change = '│', delete = '_' },
      priority = 199,
    },
    source = nil,
    delay = {
      text_change = 200,
    },
    mappings = {
      apply = 'gh',
      reset = 'gH',
      textobject = 'gh',
      goto_first = '[H',
      goto_prev = '[h',
      goto_next = ']h',
      goto_last = ']H',
    },
    options = {
      algorithm = 'histogram',
      indent_heuristic = true,
      linematch = 60,
    },
  },
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },
}
