
vim.g.mapleader = " "

local keymap = vim.keymap

-- Visual mode
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })

-- x mode
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over visual selection" })
keymap.set("x", "<leader>y", [["+y]], { desc = "Copy to system clipboard" })
keymap.set("x", "<leader>d", [["_d]], { desc = "Delete to void register" })

-- Normal mode
keymap.set("n", "J", "mzJ`z", { desc = "Join lines but remain focus" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap.set("n", "n", "nzzzv", { desc = "When searching down center screen" })
keymap.set("n", "N", "Nzzzv", { desc = "When searching up center screen" })

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })

keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next location" })
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Previous location" })

keymap.set(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" }
)


-- Good remaps from chad
-- Navigation in insert mode
keymap.set("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
keymap.set("i", "<C-e>", "<End>", { desc = "End of line" })
keymap.set("i", "<C-h>", "<Left>", { desc = "Move left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "Move right" })
keymap.set("i", "<C-j>", "<Down>", { desc = "Move down" })
keymap.set("i", "<C-k>", "<Up>", { desc = "Move up" })


keymap.set("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights" })
keymap.set("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })

