return {
	"github/copilot.vim",
	config = function()
		-- Enable Copilot on startup
		vim.g.copilot_no_tab_map = true -- Disable default <Tab> keymap (optional)
		vim.g.copilot_assume_mapped = true -- Automatically map Copilot suggestions (optional)
		vim.g.copilot_filetypes = {
			python = true,
			lua = true,
		}

		vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { noremap = true, silent = true })

		-- Customize key mappings for Copilot (optional)
		-- Press <C-y> to accept suggestion
		vim.api.nvim_set_keymap("i", "<C-y>", "copilot#Accept()", { expr = true, silent = true })
		-- Press <C-n> to get next suggestion
		vim.api.nvim_set_keymap("i", "<C-n>", "copilot#Next()", { expr = true, silent = true })

		-- Ensure Copilot only triggers suggestions when necessary
		vim.g.copilot_tab_fallback = ">" -- Use `>` for fallback
		vim.g.copilot_enable = 1 -- Make sure Copilot is enabled

		-- Set Copilot to only show suggestions when it is really useful
		vim.g.copilot_no_insert_mode_mappings = 0 -- Copilot will auto-map insert mode keys
	end,
}
