-- I put all of this into lsp.lua
return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = {
                "lua_ls",
                "cssls",
                "html",
                "tsserver"
            },
        })
    end,
}
