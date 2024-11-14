return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- LSP auto complete
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path",   -- source for file system paths
    -- "hrsh7th/cmp-cmdline", -- source for command line args
    -- 'hrsh7th/cmp-vsnip'
    "hrsh7th/vim-vsnip",
  },

  config = function()
    -- TODO: undersatnd this thing more
    local cmp = require("cmp")

    cmp.setup({

      snippet = {
        -- you have to have a snippet engine for some lsp's to do auto completion
        --https://github.com/hrsh7th/nvim-cmp
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      -- what shoudl populate the cmp menu
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
      }, {
        { name = "path" },
        { name = "buffer" },
        -- { name = "cmdline" },
      }),
    })
  end,
}
