-- This is the ufnction that handles attaching on lsp config.
-- it gets attache dusing the vim auto attach api
local on_attach = function(ev)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	local opts = { buffer = ev.buf }

	-- Just tring to put all of the errors in one place.
	local keymap = vim.keymap
	local lsp = vim.lsp
	local diagnostic = vim.diagnostic

    -- set keybinds
    opts.desc = "LSP definition"
    keymap.set("n", "gd", function()
        lsp.buf.definition()
    end, opts)

    opts.desc = "LSP declaration"
    keymap.set("n", "gD", lsp.buf.declaration, opts)

	opts.desc = "LSP hover"
	keymap.set("n", "K", lsp.buf.hover, opts)

	opts.desc = "LSP implementation"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "LSP signature help"
	keymap.set("n", "<leader>ls", function()
		lsp.buf.signature_help()
	end, opts)

	opts.desc = "LSP code action"
	keymap.set({ "n", "v" }, "<leader>ca", lsp.buf.code_action, opts)

	opts.desc = "LSP references"
	keymap.set("n", "gr", function()
		lsp.buf.references()
	end, opts)

	-- this doesnt seem to be working?
	opts.desc = "LSP definition type"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	-- i think i should err on the side of using this because it uses the lsp
	-- server to do it right
	opts.desc = "LSP rename"
	keymap.set("n", "<leader>rn", lsp.buf.rename, opts)

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    -- todo this doesnt seem tod o anything. 
	opts.desc = "Restart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

	-- TODO: should i use folke/trouble instead?
	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", diagnostic.goto_prev, opts)
	-- TODO: should i use folke/trouble instead?
	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", diagnostic.goto_next, opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", diagnostic.open_float, opts)

end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
        -- Auto complete shit
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
        -- Lsp boot popups
        "j-hui/fidget.nvim"
	},
	config = function()
		-- Get mason going first
        require("fidget").setup()
		require("mason").setup()
		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
                "tsserver",
                "html",
                "cssls",
				"lua_ls",
			},
			handlers = {
				function(server_name)
                    local cmp = require("cmp_nvim_lsp")
                    local capabilities_with_extras = vim.tbl_deep_extend(
                        "force",
                        {},
                        vim.lsp.protocol.make_client_capabilities(),
                        cmp.default_capabilities()
                    )



                    --local capabilities = require("cmp_nvim_lsp").default_capabilities()

					require("lspconfig")[server_name].setup({
						capabilities = capabilities_with_extras,
					})

                    -- So that i dont get the annoying `vim` is not a global
					require("lspconfig")["lua_ls"].setup({
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,
			},
		})

		-- If i need any custom config we can do it here :)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = on_attach,
		})

        -- https://www.youtube.com/watch?v=MuUrCcvE-Yw&t=2599s
        -- continue form here 39:30
		-- Completion shit
		local cmp = require("cmp")
		local cmp_select = {
            behavior = cmp.SelectBehavior.SelectBehavior
        }
		cmp.setup({
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
                { name ="nvim_lsp" }
            },{
                --{ name = "nvim_lsp" },
                -- { name = "luasnip" } 
				{ name = "buffer" },
			}),
		})

        vim.diagnostic.config({
            virtual_text = true
        })
	end,
}
