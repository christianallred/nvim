return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    lazy = true,
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local null_ls = require("null-ls")
        -- local null_ls_utils = require("null-ls.utils")
        -- local mason_null_ls = require("mason-null-ls")

        -- for conciseness
        local formatting = null_ls.builtins.formatting
        -- local diagnostics = null_ls.builtins.diagnostics

        -- to setup format on save
        -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            -- add package.json as identifier for root (for typescript monorepos)
            sources = {
                -- Lua
                formatting.stylua,
                formatting.gofumpt,
            },
            -- configure format on save
            on_attach = function(current_client, bufnr)
                -- Setup keybindings for formatting
                vim.keymap.set("n", "<leader>mp", vim.lsp.buf.format, { desc = "Format file" })
            end,
        })
    end,
}
