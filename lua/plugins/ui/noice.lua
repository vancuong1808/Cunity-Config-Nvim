return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    -- CMDLINE UI
    cmdline = {
      enabled = true,
      view = "cmdline_popup", -- popup đẹp, hiện giữa màn hình
      format = {
        cmdline = { pattern = "^:", icon = "󰘳 ", lang = "vim" },
        search_down = { pattern = "^/", icon = "  ", lang = "regex" },
        search_up = { pattern = "^%?", icon = "  ", lang = "regex" },
        filter = { pattern = "^:%s*!", icon = "󰞷 ", lang = "bash" },
        lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
        help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
        input = { view = "cmdline_input", icon = "󰥻 " },
      },
    },

    notify = {
      enabled = true,
      view = "notify",
    },

    -- MESSAGES (optional)
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },

    -- POPUP STYLE
    views = {
      cmdline_popup = {
        position = { row = "40%", col = "50%" },
        size = { width = 60, height = "auto" },
        border = { style = "rounded" },
        win_options = {
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
        },
      },
      mini = {
        position = { row = -2, col = "100%" },
        size = { width = 45 },
        border = {
          style = "rounded",
          padding = { 0, 1 },
        },
        win_options = {
          winblend = 0,
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
        },
      },
    },

    routes = {
      -- LSP error → notify
      -- {
      --   filter = { event = "notify", error = true },
      --   view = "notify",
      --   opts = { timeout = 3000, replace = true },
      -- },

      -- LSP progress → notify (đẹp + tự nhiên)
      {
        filter = { event = "lsp", kind = "progress" },
        view = "notify",
        opts = {
          replace = true,
        },
      },

      -- msg_show dài → popup (đúng chức năng)
      -- {
      --   filter = {
      --     event = "msg_show",
      --     min_height = 4,
      --   },
      --   view = "notify",
      --   opts = {
      --     replace = true,
      --     format = {
      --       truncate = 120,
      --     },
      --   },
      -- },

      -- msg_show ngắn → mini
      -- {
      --   filter = {
      --     event = "msg_show",
      --     max_height = 3,
      --   },
      --   view = "mini",
      -- },

      -- spam → bỏ
      -- {
      --   filter = {
      --     any = {
      --       { event = "msg_show", find = "written" },
      --       { event = "msg_show", find = "yanked" },
      --     },
      --   },
      --   opts = { skip = true },
      -- },
    },

    lsp = {
      progress = { enabled = true, view = "notify", throttle = 1000 / 20 },
      signature = {
        enabled = true,
        auto_open = { enabled = true },
      },
    },

    commands = {
      all = {
        view = "popup",
        opts = {
          enter = true,
          format = "details",
          size = {
            width = 0.7,
            height = 0.6,
          },
          border = { style = "rounded" },
        },
        filter = {},
      },
    },

    -- PRESETS
    presets = {
      bottom_search = false,
      command_palette = true,
      long_message_to_split = false,
      lsp_doc_border = true,
    },
  },
}
