return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- For installing language servers
    "williamboman/mason-lspconfig.nvim",
    -- Lsp boot popups
    "j-hui/fidget.nvim",
  },
  config = function()
    -- Get mason going first
    require("fidget").setup()

    require("mason").setup()

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = {
        --				"lua_ls",
        --				"tsserver",
      },
    })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        -- this will need to stay here until we get a fix for the
        -- rename in mason-lspconfig
        if server_name == "tsserver" then
          server_name = "ts_ls"
        end

        local config = {}
        if server_name == "lua_ls" then
          config = {

            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          }
        end

        require("lspconfig")[server_name].setup(config)
      end,
    })
  end,
}
