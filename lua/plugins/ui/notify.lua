return {
  "rcarriga/nvim-notify",
  opts = {
    -- ===== Behavior =====
    timeout = 2500,
    fps = 60,
    level = vim.log.levels.INFO,

    -- ===== Size =====
    max_width = 60,
    max_height = 8,

    -- ===== Render style =====
    render = "default", -- {minimal, default, simple, compact, wrapped-compact}
    stages = "fade_in_slide_out",            -- {fade, slide, fade_in_slide_out, static}

    -- ===== Layout =====
    top_down = true,           -- notify mới ở dưới
    minimum_width = 20,

    -- ===== Text =====
    wrap = true,

    -- ===== Icons =====
    icons = {
      ERROR = "",
      WARN  = "",
      INFO  = "",
      DEBUG = "",
      TRACE = "✎",
    },

    -- ===== Background / border =====
    background_colour = "#000000",
  },
}
