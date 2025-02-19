
vim.keymap.set("n", "<PageUp>", ":bprevious<CR>", {noremap = false, silent = true } )
vim.keymap.set("n", "<PageDown>", ":bnext<CR>", {noremap = false, silent = true } )
vim.keymap.set("v", "<C-C>", "\"+y", {noremap = false, silent = true })

-- Find files using Telescope command-line sugar.
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", {noremap = false, silent = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", {noremap = false, silent = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", {noremap = false, silent = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", {noremap = false, silent = true })

