local opt = vim.opt

opt.fillchars = {
	stl = "─",
}
opt.shadafile = vim.fn.stdpath("data") .. "/shada/main.shada"
opt.number = true --Hiện số dòng tuyệt đối
opt.relativenumber = true --Hiện số dòng tương đối
opt.cursorline = true --Highlight dòng hiện tại

-- True color in terminal (important for modern themes + transparency look)
if not vim.g.neovide then
  opt.termguicolors = true
end

opt.expandtab = true --tab == space
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true --Điều chỉnh khi có Treesitter + LSP
opt.autoindent = true
opt.winbar = ""
opt.wrap = false --Không wrap dòng dài
opt.scrolloff = 8 --??
opt.sidescrolloff = 8 --??

opt.splitbelow = true
opt.splitright = true

-- Smart Search
opt.ignorecase = true
opt.smartcase = true
-- Realtime + Highlight Search
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true --Highlight ngoặc matching

opt.clipboard = "unnamedplus" --Dùng clipboard hệ điều hành
opt.mouse = "a" --Dùng chuột

-- opt.guifont = "JetBrainsMonoNL Nerd Font Propo:h11"

opt.backup = false
opt.swapfile = false
opt.undofile = true

opt.signcolumn = "yes" --Luôn chừa cột sign (LSP, Git)
opt.fillchars = { eob = " " } --Xóa dấu ~ ở cuối

opt.completeopt = { "menu", "menuone", "noselect" }
opt.wildmenu = false
opt.wildoptions = 'pum'

opt.timeoutlen = 300
opt.updatetime = 200
opt.lazyredraw = true

opt.title = true
opt.titleold = ''
opt.laststatus = 3
opt.cmdheight = 0

vim.diagnostic.config({
  virtual_text = false,  -- tắt chữ đỏ inline
  signs = true,          -- bật signcolumn
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  },
})
