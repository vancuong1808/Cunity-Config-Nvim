return {
  "saghen/blink.cmp",
  version = "*",
  lazy = false,
  priority = 950,
  dependencies = {
    "zbirenbaum/copilot.lua",
    "rafamadriz/friendly-snippets",
    "fang2hou/blink-copilot",
    "xzbdmw/colorful-menu.nvim",
  },
  opts = {
    -- Appearance (ui)
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },

    -- Completion behavior
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winblend = 8,
        },
      },

      ghost_text = { 
        enabled = true 
      },

      keyword = {
          range = 'prefix',
      },

      menu = {
        winblend = 10,
        min_width = 15,
        max_height = 10,
        border = "rounded",
        scrolloff = 2,
        scrollbar = true,
        direction_priority = { 's', 'n' },
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection",
        auto_show = true,
        auto_show_delay_ms = 0,
        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            local row = tonumber(pos[1]) or 1
            local col = tonumber(pos[2]) or 0
            return { math.max(row - 1, 0), math.max(col, 0) }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,

        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
            { "source_name" },
          },
          components = {
            label = {
              text = function(ctx)
                return require("colorful-menu").blink_components_text(ctx)
              end,
              highlight = function(ctx)
                return require("colorful-menu").blink_components_highlight(ctx)
              end,
            },

            kind_icon = {
              highlight = function(ctx)
                return { { group = ctx.kind_hl, priority = 20000 } }
              end,
            },
          },

          treesitter = { 'lsp' },
        },
      },

      trigger = {
        show_on_keyword = true
      },

      list = { 
          selection = { 
              preselect = false, 
              auto_insert = true, 
              -- preselect = function(ctx) return not require('blink.cmp').snippet_active({ direction = 1 }) end, 
              -- auto_insert = function(ctx) return vim.bo.filetype ~= 'markdown' end, 
        }
      },
    },

    -- Sources (data)
    sources = {
        default = {
            "copilot",
            "lsp",
        "easy-dotnet",
            "path",
            "snippets",
            "buffer",
        },
        providers = {
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                async = true,
                score_offset = 100,
            },
            cmdline = {
              min_keyword_length = function(ctx)
                if ctx.mode == "cmdline"
                   and not ctx.line:find(" ") then
                  return 3
                end
                return 0
              end,
            },
            ["easy-dotnet"] = {
              name = "easy-dotnet",
              enabled = true,
              module = "easy-dotnet.completion.blink",
              score_offset = 10000,
              async = true,
            },
        },
    },
    fuzzy = {
      implementation = "prefer_rust",
    },

    -- Keymap
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ['<C-u>'] = { 'scroll_signature_up', 'fallback' },
      ['<C-d>'] = { 'scroll_signature_down', 'fallback' },
      ['<C-x>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    -- Signature Help
    signature = {
      enabled = true,

      trigger = {
        enabled = true,
        show_on_keyword = false,
        show_on_trigger_character = true,
        show_on_insert = false,
        show_on_insert_on_trigger_character = true,
        blocked_trigger_characters = {},
        blocked_retrigger_characters = {},
      },

      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "rounded",
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        scrollbar = false,
        direction_priority = { 'n', 's' },

        treesitter_highlighting = true,
        show_documentation = true,
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        ['<Tab>'] = { 'accept' },
        ['<CR>'] = { 'accept_and_enter', 'fallback' },
      },
      completion = {
          menu = {
            auto_show = function(ctx)
                return vim.fn.getcmdtype() == ':'
                -- enable for inputs as well, with:
                -- or vim.fn.getcmdtype() == '@'
              end,
          },
          ghost_text = {
            enabled = false,
          },
      },
      sources = function()
        local type = vim.fn.getcmdtype()

        if type == ":" then
          return { "cmdline", "path" }
        elseif type == "/" or type == "?" then
          return { "buffer" }
        end

        return {}
      end,
    },
  },
}
