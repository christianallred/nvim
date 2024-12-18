-- none-ls gives me a way to attach arbitrary things to the lsp
-- this is nice becuase then i can do things like formating
-- which would not normally be in teh perview of lsp
-- TODO: i think i can replace this wiht conform instead... seems cleaner.
-- should i use none-ls for linting too?
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    -- "jay-babu/mason-null-ls.nvim",
  },
  lazy = true,
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local null_ls = require("null-ls")

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- do i have to dot his for formatting?
        null_ls.builtins.formatting.stylua,
        --null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.prettier,
        -- Go formatting
        null_ls.builtins.formatting.gofmt,
      },

      -- configure format on save
      on_attach = function(client, bufnr)
        -- Setup keybindings for formatting
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                async = false,
                filter = function(_client)
                  -- i want prettier to format my code not the ts server
                  if _client.name == "ts_ls" then
                    return false
                  end
                  return true
                end,
              })
            end,
          })
        end

        vim.keymap.set("n", "<leader>mp", vim.lsp.buf.format, { desc = "Format file" })
      end,
    })

    -- require("mason-null-ls").setup({
    -- 	ensure_installed = nil,
    -- 	automatic_installation = true,
    -- })
  end,
}
