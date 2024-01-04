-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

return {
	"nvim-tree/nvim-tree.lua",
	enabled = true,
	event = "VeryLazy",
	dependencies = {"nvim-tree/nvim-web-devicons"},
	config = function()
		local nvimtree = require("nvim-tree")
		
		-- Turn of netrw default vim file explorere
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- set termguicolors to enable hightlight groups
		vim.opt.termguicolors = true


		-- nvimtree setup
		nvimtree.setup({
			view = {
				width = 30
			}
		})
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer" })
	end,
}
