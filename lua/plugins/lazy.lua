local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.lsp.mason"),
    require("plugins.lsp.mason-lsp"),
    require("plugins.lsp.mason-tool-installer"),
    require("plugins.lsp.lspconfig"),
    require("plugins.lsp.blink"),
    require("plugins.lsp.csharp-ls"),
    require("plugins.lsp.roslyn"),

    require("plugins.utils.colorful-menu"),
    require("plugins.utils.dap"),
    require("plugins.utils.navic"),    
    require("plugins.utils.incline"),
    require("plugins.utils.mini-diff"),
    require("plugins.utils.gitsigns"),
    require("plugins.utils.colorizer"),
    require("plugins.utils.indent-blankline"),
    require("plugins.utils.autopairs"),
    require("plugins.utils.surround"),
    require("plugins.utils.flash"),
    require("plugins.utils.rainbow-delimiter"),
    require("plugins.utils.mini-ai"),
    require("plugins.utils.mini-comment"),
    require("plugins.utils.treesitter"),
    require("plugins.utils.conform"),
    require("plugins.utils.trouble"),
    require("plugins.utils.todo-comments"),
    require("plugins.utils.project"),
    require("plugins.utils.leetcode"),
    require("plugins.utils.store"),
    require("plugins.utils.endpoint"),
    require("plugins.utils.easy-dotnet"),
    require("plugins.utils.neonuget"),
    require("plugins.utils.lazygit"),
    require("plugins.utils.dadbod"),
    require("plugins.utils.yazi"),
    require("plugins.utils.markdown-preview"),
    require("plugins.utils.floaterm"),
    require("plugins.utils.nerdtree"),

    require("plugins.ui.telescope"),
    require("plugins.ui.notify"),
    require("plugins.ui.noice"),
    require("plugins.ui.themes"),
    require("plugins.ui.theme-switcher"),
    require("plugins.ui.which-key"),
    require("plugins.ui.dashboard"),
    require("plugins.ui.lualine"),

    -- Terminal-only animations (auto-disabled in Neovide)
    require("plugins.ui.smear-cursor"),
    require("plugins.utils.neoscroll"),
}, {
    rocks = {
        enabled = false,
    },
})
