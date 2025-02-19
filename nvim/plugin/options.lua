
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd "colorscheme catppuccin-mocha"
vim.api.nvim_set_hl(0, "SpellBad", {underline=true})
vim.api.nvim_set_hl(0, "SpellLocal", {underline=true})
vim.api.nvim_set_hl(0, "SpellRare", {underline=true})
vim.api.nvim_set_hl(0, "SpellCap", {underline=true})


vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.wrap = true

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.spell = true
vim.o.spelllang = "en"

vim.o.showtabline = 2

vim.opt.mouse = "a" 

vim.opt.syntax.enable = true


vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
