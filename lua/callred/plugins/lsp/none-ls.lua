-- none-ls gives me a way to attach arbitrary things to the lsp
-- this is nice becuase then i can do things like formating
-- which would not normally be in teh perview of lsp
-- TODO: i think i can replace this wiht conform instead... seems cleaner.
-- should i use none-ls for linting too?
return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		-- "jay-babu/mason-null-ls.nvim",
	},
	lazy = true,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local null_ls = require("null-ls")

		-- local mason_null_ls = require("mason-null-ls")

		-- local diagnostics = null_ls.builtins.diagnostics

		-- to setup format on save
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = {
				-- do i have to dot his for formatting?
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.gofmt,
			},

			-- configure format on save
			on_attach = function(client, bufnr)
				-- Setup keybindings for formatting
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
							-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
							vim.lsp.buf.format({ async = false })
						end,
					})
				end

				vim.keymap.set("n", "<leader>mp", vim.lsp.buf.format, { desc = "Format file" })
			end,
		})
	end,
}
