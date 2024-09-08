return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"javascript",
				"typescript",
				"lua",
			},
			auto_install = true,
			highlight = {
				enabled = true,
			},
			indent = {
				enabled = true,
			},
		})
	end,
}
