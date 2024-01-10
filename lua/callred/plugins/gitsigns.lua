local function on_attach(bufnr)
    local gs = package.loaded.gitsigns

    local function remap(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    remap("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, { expr = true, desc = "GSigns: next hunk" })

    remap("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end, { expr = true, desc = "GSigns: prev hunk" })

    -- Actions
    remap("n", "<leader>hs", gs.stage_hunk, { desc = "GSigns: stage hunk" })
    remap("n", "<leader>hr", gs.reset_hunk, { desc = "GSigns: reset hunk" })

    remap("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    remap("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)
    remap("n", "<leader>hS", gs.stage_buffer, { desc = "GSigns: stage buffer" })
    remap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "GSigns: undo stage buffer" })
    remap("n", "<leader>hR", gs.reset_buffer, { desc = "GSigns: reset buffer" })
    remap("n", "<leader>hp", gs.preview_hunk, { desc = "GSigns: preview hunk" })
    remap("n", "<leader>hb", function()
        gs.blame_line({ full = true })
    end, { desc = "GSigns: blame line" })
    remap("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "GSigns: toggle current blame line" })
    remap("n", "<leader>hd", gs.diffthis, { desc = "GSigns: diff this" })
    remap("n", "<leader>hD", function()
        gs.diffthis("~")
    end, { desc = "GSigns: diff this ~" })
    remap("n", "<leader>td", gs.toggle_deleted, { desc = "GSigns: toggle deleted" })

    -- Text object
    remap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>" )
end

return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup({
            on_attach = on_attach,
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true,
            },
            auto_attach = true,
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = "single",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            yadm = {
                enable = false,
            },
        })
    end,
}
