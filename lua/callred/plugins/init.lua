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
        }
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        config = function()
            vim.cmd("colorscheme tokyonight")
            vim.api.nvim_set_hl(0, "Normal", {
                bg = "none",
            })
            vim.api.nvim_set_hl(0, "NormalFloat", {
                bg = "none",
            })
        end
    },
    {
        "rose-pine/neovim",
        config = function()
            --vim.cmd("colorscheme rose-pine")
        end
    }
}
