 return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    update = ":TSUpdate",
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        -- General configuration
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,     -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                }
            },
        })
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
        keymap.set(
            "n", "<leader>fa", "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",{ desc = "Find all" }
        )
        keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Find using grep" })

        keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
        keymap.set("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Find in current buffer" })

        keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Find help" })
        keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Find old files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })

        -- Git
        keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Find Git commits" })
        keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Find Git status" })
        keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "Fuzzy find non git-ignorred files" })

        -- Bookmarks
        keymap.set("n", "<leader>gt", "<cmd>Telescope marks<CR>", { desc = "Find bookmarks" })

        -- Undo
        -- TODO: this is an extension that we ae need
        -- keymap.set("n", "<leader>u", "<cmd>Telescope undo<CR>", { desc = "Find undo history" })
    end
}





