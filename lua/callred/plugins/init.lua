return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			--
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			vim.cmd("colorscheme tokyonight-night")
		end,
	},
	-- TODO: dont know that i really care about this thing
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "[m]aximize [s]plits toggler" },
		},
	},
	--[[
	{
		"rose-pine/neovim",
		lazy = false,
		config = function()
			vim.cmd("colorscheme rose-pine")
		end,
	},
  ]]
}
