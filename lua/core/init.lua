-- Compatibility shim: some plugins still call deprecated API.
-- Map it to the modern API to avoid :checkhealth vim.deprecated warnings.
if vim.lsp and vim.lsp.get_clients and vim.lsp.buf_get_clients then
	vim.lsp.buf_get_clients = function(bufnr)
		local target_bufnr = (type(bufnr) == "number") and bufnr or 0
		return vim.lsp.get_clients({ bufnr = target_bufnr })
	end
end

require("core.options")
require("core.neovide")
require("core.keymaps")
require("core.ui.blink-cmp-highlights")
require("core.ui.noice-highlights")
require("core.autocmds")
