return {
	"preservim/nerdtree",
	dependencies = {
		"ryanoasis/vim-devicons",
	},
	init = function()
		vim.g.NERDTreeWinPos = "left"
		vim.g.NERDTreeWinSize = 30
		vim.g.NERDTreeShowHidden = 1
		vim.g.NERDTreeMinimalUI = 1
		vim.g.webdevicons_enable_nerdtree = 1
		vim.g.NERDTreeIgnore = { ".git", "node_modules", ".cache" }
		
		-- Auto close if NERDTree is last window
		vim.api.nvim_create_autocmd("BufEnter", {
			pattern = "*",
			callback = function()
				if vim.fn.winnr("$") == 1 and vim.fn.exists("b:NERDTree") == 1 then
					vim.cmd("quit")
				end
			end,
		})
	end,
}
