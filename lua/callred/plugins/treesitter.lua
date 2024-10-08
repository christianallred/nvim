return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"lua",
				"go",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			-- TODO: what
			indent = {
				enable = true,
			},
			-- TODO: look at incremental selection
			-- TODO: whta
		})
	end,
}
