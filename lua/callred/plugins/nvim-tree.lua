return {
	"nvim-tree/nvim-tree.lua",
    enabled = true,
	event = "VeryLazy",
	dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
		local nvimtree = require("nvim-tree")
		-- nvimtree setup
		nvimtree.setup({
            filters = {
                dotfiles = false,
                custom = {
                    "^.git$"
                }
            }
		})
		vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer" })
	end,
}
