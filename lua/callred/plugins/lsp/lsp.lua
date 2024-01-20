-- This is the ufnction that handles attaching on lsp config.
-- it gets attache dusing the vim auto attach api
local on_attach = function(ev)
	-- Enable completion triggered by <c-x><c-o>
	vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Just tring to put all of the errors in one place.
	local lsp = vim.lsp
	local diagnostic = vim.diagnostic

	local function remap(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = ev.buf
		vim.keymap.set(mode, l, r, opts)
	end

	-- set keybinds
	remap("n", "gd", function()
		lsp.buf.definition()
	end, { desc = "LSP Definition" })
	remap("n", "gD", lsp.buf.declaration, { desc = "LSP Declaration" })
	remap("n", "K", lsp.buf.hover, { desc = "Lsp Hover" })
	remap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "LSP implementation" })
	remap({ "n", "v" }, "<leader>ca", lsp.buf.code_action, { desc = "LSP code action" })
	remap("n", "gr", function()
		lsp.buf.references()
	end, { desc = "LSP references" })
    remap("n", "<leader>ls", function()
        lsp.buf.signature_help()
    end, { desc = "LSP signature help" })

	-- this doesnt seem to be working?
	remap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "LSP definition type" })
	remap("n", "<leader>rn", lsp.buf.rename, { desc = "LSP rename" })
	remap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", { desc = "Show buffer diagnostics" })

	remap("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

	-- TODO: should i use folke/trouble instead?
	remap("n", "[d", diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	remap("n", "]d", diagnostic.goto_next, { desc = "Go to next diagnostic" })
	remap("n", "<leader>d", diagnostic.open_float, { desc = "Show line diagnostics" })
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- For installing language servers
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- Auto complete shit
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
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

		-- Completion shit
		local cmp = require("cmp")
		local cmp_select = {
			behavior = cmp.SelectBehavior.SelectBehavior,
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
				{ name = "nvim_lsp" },
			}, {
				--{ name = "nvim_lsp" },
				-- { name = "luasnip" }
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			virtual_text = true,
		})
	end,
}
