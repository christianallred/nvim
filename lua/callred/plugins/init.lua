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
