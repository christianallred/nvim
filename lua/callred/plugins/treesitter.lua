return {
    "nvim-treesitter/nvim-treesitter",
    config = function() 
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
                "lua",
            },
            highlight = {
                enabled = true,
                use_languagetree = true,
            },
            indent = { enabled = true }, 
        })
    end
}
