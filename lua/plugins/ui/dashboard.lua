return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local function open_yazi()
      local ok, yazi = pcall(require, "yazi")
      if ok then
        yazi.yazi()
        return
      end
      vim.notify("yazi.nvim not available", vim.log.levels.WARN)
    end

    local function open_explorer()
      if vim.fn.exists(":Neotree") == 2 then
        vim.cmd("Neotree toggle")
        return
      end
      if vim.fn.exists(":NERDTreeToggle") == 2 then
        vim.cmd("NERDTreeToggle")
        return
      end
      vim.notify("No file explorer command found (Neotree/NERDTree)", vim.log.levels.WARN)
    end

    local function open_leetcode()
      if vim.fn.exists(":Leet") == 2 then
        vim.cmd("Leet")
        return
      end
      vim.notify("LeetCode not available yet. Run :Lazy sync then restart Neovim.", vim.log.levels.WARN)
    end

    local function open_store()
      if vim.fn.exists(":Store") == 2 then
        vim.cmd("Store")
        return
      end
      vim.notify("Store.nvim not available yet. Run :Lazy sync then restart Neovim.", vim.log.levels.WARN)
    end

    local function open_lazy()
      if vim.fn.exists(":Lazy") == 2 then
        vim.cmd("Lazy")
        return
      end
      vim.notify("lazy.nvim not available", vim.log.levels.WARN)
    end

    local function open_mason()
      if vim.fn.exists(":Mason") == 2 then
        vim.cmd("Mason")
        return
      end
      vim.notify("mason.nvim not available", vim.log.levels.WARN)
    end

    dashboard.section.header.val = {
      "",
      "",
      "",
      "   ██████╗██╗   ██╗███╗   ██╗██╗████████╗██╗   ██╗",
      "  ██╔════╝██║   ██║████╗  ██║██║╚══██╔══╝╚██╗ ██╔╝",
      "  ██║     ██║   ██║██╔██╗ ██║██║   ██║    ╚████╔╝ ",
      "  ██║     ██║   ██║██║╚██╗██║██║   ██║     ╚██╔╝  ",
      "  ╚██████╗╚██████╔╝██║ ╚████║██║   ██║      ██║   ",
      "   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝   ╚═╝      ╚═╝   ",
      "",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      "",
      "",
      "",
    }

    dashboard.section.buttons.val = {
      dashboard.button("y", "  Yazi", open_yazi),
      dashboard.button("e", "  Explorer", open_explorer),
      dashboard.button("l", "󰈙  LeetCode", open_leetcode),
      dashboard.button("s", "🛒  Store", open_store),
      dashboard.button("L", "󰒲  Lazy", open_lazy),
      dashboard.button("m", "󰏗  Mason", open_mason),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    -- Hide statusline/tabline on the dashboard (restore when alpha buffer closes)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function(args)
        vim.opt_local.laststatus = 0
        vim.opt_local.showtabline = 0
        vim.api.nvim_create_autocmd("BufUnload", {
          buffer = args.buf,
          once = true,
          callback = function()
            vim.opt.laststatus = 3
            vim.opt.showtabline = 2
          end,
        })
      end,
    })
  end,
}
