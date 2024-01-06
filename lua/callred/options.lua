local opt = vim.opt

-- nunber lines
opt.nu = true
opt.relativenumber = true

-- tab stuff
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
opt.undofile = true

opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
-- opt.isfname:append("@-@")

opt.updatetime = 50
opt.colorcolumn = "80"
opt.exrc = true


-- Turn of netrw default vim file explorere
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


