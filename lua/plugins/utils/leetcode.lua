return {
  "kawre/leetcode.nvim",
  cmd = "Leet",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- picker
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    plugins = {
      non_standalone = true,
    },
    picker = {
      provider = "telescope",
    },
  },
  config = function(_, opts)
    local ok, leetcode = pcall(require, "leetcode")
    if ok and leetcode and leetcode.setup then
      leetcode.setup(opts)
    end

    local function open_dashboard_from_ui()
      -- Avoid winfixbuf errors by opening Alpha in a fresh tab.
      vim.cmd("tabnew")
      local ok_alpha, alpha = pcall(require, "alpha")
      if ok_alpha and alpha and alpha.start then
        alpha.start(true)
        return
      end
      if vim.fn.exists(":Alpha") == 2 then
        pcall(vim.cmd, "Alpha")
        return
      end
      vim.notify("alpha-nvim not available", vim.log.levels.WARN)
    end

    local group = vim.api.nvim_create_augroup("LeetCodeBackKey", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
      group = group,
      callback = function(args)
        local ft = vim.bo[args.buf].filetype or ""
        local name = vim.api.nvim_buf_get_name(args.buf) or ""

        -- leetcode.nvim buffers can vary; match by filetype or buffer name.
        if not (ft:lower():find("leet") or name:lower():find("leet")) then
          return
        end

        vim.keymap.set("n", "q", open_dashboard_from_ui, {
          buffer = args.buf,
          silent = true,
          nowait = true,
          desc = "Back to Dashboard",
        })
      end,
    })
  end,
}
