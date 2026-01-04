return {
  "voldikss/vim-floaterm",
  keys = {
    { "<F12>", "<cmd>FloatermToggle<cr>", desc = "Toggle Floaterm", mode = "n" },
    { "<F11>", "<cmd>FloatermNew<cr>", desc = "New Floaterm", mode = "n" },
    { "<F10>", "<cmd>FloatermKill<cr>", desc = "Kill Floaterm", mode = "n" },

    -- When inside terminal-mode, exit to normal-mode first
    { "<F12>", [[<C-\><C-n><cmd>FloatermToggle<cr>]], desc = "Toggle Floaterm", mode = "t" },
    { "<F11>", [[<C-\><C-n><cmd>FloatermNew<cr>]], desc = "New Floaterm", mode = "t" },
    { "<F10>", [[<C-\><C-n><cmd>FloatermKill<cr>]], desc = "Kill Floaterm", mode = "t" },
  },
  config = function()
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_position = "center"
    vim.g.floaterm_borderchars = "─│─│╭╮╯╰"
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_autohide = 1

    local group = vim.api.nvim_create_augroup("FloatermKeymaps", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "floaterm",
      callback = function(args)
        local opts = { buffer = args.buf, silent = true }
        vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)
        vim.keymap.set("t", "<Left>", "<C-\\><C-n><C-w>h", opts)
        vim.keymap.set("t", "<Down>", "<C-\\><C-n><C-w>j", opts)
        vim.keymap.set("t", "<Up>", "<C-\\><C-n><C-w>k", opts)
        vim.keymap.set("t", "<Right>", "<C-\\><C-n><C-w>l", opts)
      end,
    })
  end,
}
