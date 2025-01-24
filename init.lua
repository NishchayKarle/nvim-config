require("core.options")
require("core.keymaps")

-- LAZY NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- require("plugins.colorscheme"),
	require("plugins.lsp"),
	require("plugins.telescope"),
	require("plugins.neotree"),
	require("plugins.bufferline"),
	require("plugins.lualine"),
	require("plugins.treesitter"),
	require("plugins.autocompletion"),
	require("plugins.format"),
	require("plugins.gitsigns"),
	require("plugins.alpha"),
	require("plugins.indentline"),
	require("plugins.misc"),
	require("plugins.copilot"),
})

vim.cmd("colorscheme vim")
vim.cmd([[highlight SignColumn guibg=vim]])
