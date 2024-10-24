return {
	"williamboman/mason.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- For installing language servers
		"williamboman/mason-lspconfig.nvim",
		-- Lsp boot popups
		"j-hui/fidget.nvim",
	},
	config = function()
		-- Get mason going first
		require("fidget").setup()

		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				-- mabe use this for style isntalls
				-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
				-- lua
				"lua_ls",
				-- css
				"cssls",
				-- typescript
				"ts_ls",
				-- go things
				"gopls",
			},
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local settings = {}
				if server_name == "lua_ls" then
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
						},
					}
				end
				-- this is so that we can have some autocomplete
				local capabilities = vim.lsp.protocol.make_client_capabilities()
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

				require("lspconfig")[server_name].setup({
					settings = settings,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
