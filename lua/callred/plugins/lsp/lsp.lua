-- This is the ufnction that handles attaching on lsp config.
-- it gets attache dusing the vim auto attach api
local on_attach = function(ev)
	-- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

	local function remap(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = ev.buf
		vim.keymap.set(mode, l, r, opts)
	end

    local builtin = require("telescope.builtin")
	-- set keybinds
    remap("n", "gd", builtin.lsp_definitions, { desc = "[g]oto [d]efinition" })
    remap("n", "gr", builtin.lsp_references, { desc = "[g]oto [r]eferences" })
    remap("n", "gi", builtin.lsp_implementations, { desc = "[g]oto [i]mplementation" })
    remap("n", "gD", builtin.lsp_type_definitions, { desc = "[g]oto [D]eclaration" })
    remap("n", "<leader>ds", builtin.lsp_document_symbols, {desc = "[d]ocument [s]ymbols"}) 
    remap("n", "K", vim.lsp.buf.hover, { desc = "Lsp Hover" })
    remap("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
    remap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
    remap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })

	remap("n", "<leader>rs", ":LspRestart<CR>", { desc = "Restart LSP" })

    -- TODO: should i use folke/trouble instead?
    remap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
	remap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
	remap("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
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
