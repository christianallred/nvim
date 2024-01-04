return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        mason.setup()
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = " ✗",
                },
                -- Todo: there are all defaults shoudl we delete these? 
                keymaps = {
                    toggle_server_expand = "<CR>",
                    install_server = "i",
                    update_server = "u",
                    check_server_version = "c",
                    update_all_servers = "U",
                    check_outdated_servers = "C",
                    uninstall_server = "X",
                    cancel_installation = "<C-c>",
                },
            },
            max_concurrent_installers = 4,
            ensure_installed = {
                -- lua stuff
                "lua-language-server",
                "stylua",

                -- web dev stuff
                "css-lsp",
                "html-lsp",
                "typescript-language-server",

            },
        })

        mason_lspconfig.setup({
            automatic_installation = true,
        })
    end,
}
