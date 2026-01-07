return {
  "sphamba/smear-cursor.nvim",
  enabled = function()
    return not vim.g.neovide
  end,
  event = "VeryLazy",
  opts = {
    -- Keep the effect close to Neovide's "smooth cursor" feel,
    -- while staying light to avoid terminal stutter.
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,

    smear_insert_mode = true,

    -- Slightly snappier than defaults, but still smooth.
    stiffness = 0.75,
    trailing_stiffness = 0.55,
    stiffness_insert_mode = 0.75,
    trailing_stiffness_insert_mode = 0.55,
    damping = 0.9,
    damping_insert_mode = 0.92,
    distance_stop_animating = 0.35,
    distance_stop_animating_insert_mode = 0.35,

    -- NOTE: If you see low FPS, try *increasing* this (less redraws).
    -- Default is 17ms in the plugin.
    -- time_interval = 17,
  },
  config = function(_, opts)
    -- Command (note):
    -- - :SmearCursorToggle (or :lua require("smear_cursor").toggle())
    --
    -- This plugin is auto-disabled in Neovide.
    require("smear_cursor").setup(opts)
  end,
}
