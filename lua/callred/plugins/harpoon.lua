return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- local harpoon = require("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        local keymap = vim.keymap
        keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: Add" })
        keymap.set("n", "<leader>hr", mark.rm_file, { desc = "Harpoon: Remove" })
        keymap.set("n", "<leader>hc", mark.clear_all, { desc = "Harpoon: Clear" })
        keymap.set("n", "<leader>ho", ui.toggle_quick_menu, { desc = "Harpoon: Menu" })

        -- TODO: find a better maps for this
        keymap.set("n", "<A-j>", function()
            ui.nav_file(1)
        end)
        keymap.set("n", "<A-k>", function()
            ui.nav_file(2)
        end)
        keymap.set("n", "<A-l>", function()
            ui.nav_file(3)
        end)
    end,
}
