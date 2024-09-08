-- This is the ufnction that handles attaching on lsp config.
-- it gets attache dusing the vim auto attach api
local on_attach = function(ev)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

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
  remap("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "[d]ocument [s]ymbols" })
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

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = on_attach,
    })
  end,
}
