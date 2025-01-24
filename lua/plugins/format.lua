return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim", -- ensure dependencies are installed
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting -- to setup formatters
		local diagnostics = null_ls.builtins.diagnostics -- to setup linters

		-- Formatters & linters for mason to install
		require("mason-null-ls").setup({
			ensure_installed = {
				"prettier", -- ts/js formatter
				"stylua", -- lua formatter
				"eslint_d", -- ts/js linter
				"shfmt", -- Shell formatter
				"checkmake", -- linter for Makefiles
				"ruff", -- Python linter and formatter
				"black", -- Python formatter
				"isort", -- Python import sorter
				"clang-format", -- C/C++ formatter
				"gofumpt", -- Go formatter
				"goimports", -- Go imports formatter
				-- 'rustfmt',       -- Rust formatter
				"yamlfmt", -- YAML formatter
				"markdownlint", -- Markdown linter
			},
			automatic_installation = true,
		})

		local sources = {
			-- Diagnostics
			diagnostics.checkmake,

			-- Formatters
			formatting.prettier.with({
				filetypes = { "html", "json", "yaml", "markdown", "css", "javascript", "typescript" },
			}),
			formatting.stylua,
			formatting.shfmt.with({ args = { "-i", "4" } }),
			formatting.terraform_fmt,
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),
			formatting.black.with({ extra_args = { "--line-length", "88" } }), -- Python formatter
			formatting.isort.with({ extra_args = { "--profile", "black" } }), -- Sort Python imports with Black profile
			formatting.clang_format, -- C/C++ formatter
			formatting.gofumpt, -- Go formatter
			formatting.goimports, -- Go imports formatter
			-- formatting.rustfmt,            -- Rust formatter
			formatting.yamlfmt, -- YAML formatter
		}

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					-- Set up a key mapping for formatting
					vim.api.nvim_buf_set_keymap(
						bufnr,
						"n",
						"<leader>af",
						"<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
						{ noremap = true, silent = true, desc = "Format buffer" }
					)
				end
			end,
		})
	end,
}
