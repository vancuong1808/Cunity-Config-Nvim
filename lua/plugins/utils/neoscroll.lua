return {
  "karb94/neoscroll.nvim",
  enabled = function()
    return not vim.g.neovide
  end,
  event = "VeryLazy",
  opts = {
    mappings = {},
    hide_cursor = true,
    stop_eof = true,
    -- With global 'scrolloff=8' this can prevent reaching the first/last few
    -- lines because the cursor is kept inside the scrolloff margin.
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    duration_multiplier = 1.0,
    easing = "quadratic",
    -- NOTE: Disable neoscroll's built-in performance_mode.
    -- It toggles Treesitter highlight using legacy :TSBufDisable/:TSBufEnable
    -- commands, which can be missing depending on your nvim-treesitter version.
    performance_mode = false,
    ignored_events = { "WinScrolled", "CursorMoved" },
    pre_hook = function(info)
      if info == "cursorline" then
        -- 'scrolloff' can cause large jumps near BOF/EOF (it tries to keep
        -- the cursor away from window edges). Temporarily disable it only
        -- while animating our arrow-key scroll.
        vim.w._neoscroll_saved_scrolloff = vim.wo.scrolloff
        vim.wo.scrolloff = 0
        vim.wo.cursorline = false
      end
    end,
    post_hook = function(info)
      if info == "cursorline" then
        vim.wo.cursorline = true
        if vim.w._neoscroll_saved_scrolloff ~= nil then
          vim.wo.scrolloff = vim.w._neoscroll_saved_scrolloff
          vim.w._neoscroll_saved_scrolloff = nil
        end
      end
    end,
  },
  config = function(_, opts)
    -- Commands (note):
    -- - :NeoscrollEnable / :NeoscrollDisable (provided by neoscroll)
    --
    -- This plugin is auto-disabled in Neovide (we use Neovide's native animations).
    require("neoscroll").setup(opts)
  end,
  keys = {
    {
      "<Up>",
      function()
        require("neoscroll").scroll(-1, { duration = 70, info = "cursorline" })
      end,
      mode = "n",
      desc = "Smooth scroll up (1 line)",
    },
    {
      "<Down>",
      function()
        require("neoscroll").scroll(1, { duration = 70, info = "cursorline" })
      end,
      mode = "n",
      desc = "Smooth scroll down (1 line)",
    },
    {
      "<S-Up>",
      function()
        require("neoscroll").scroll(-5, { duration = 120, info = "cursorline" })
      end,
      mode = "n",
      desc = "Smooth scroll up (5 lines)",
    },
    {
      "<S-Down>",
      function()
        require("neoscroll").scroll(5, { duration = 120, info = "cursorline" })
      end,
      mode = "n",
      desc = "Smooth scroll down (5 lines)",
    },
  },
}
