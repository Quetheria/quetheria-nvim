
vim.g["conjure#log#hud#enabled"] = false
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#log#fold#enabled"] = true
vim.g["conjure#mapping#log_split"] = "ls"
vim.g["conjure#log#width"] = .2
local log = require("conjure.log")


local augroups = {}
local function augroup(name)
  if not augroups[name] then
    augroups[name] = vim.api.nvim_create_augroup(name, { clear = true })
  end
  return augroups[name]
end

local autocmd = vim.api.nvim_create_autocmd


autocmd({'BufAdd', 'BufNew', 'VimEnter'},{
  group = augroup('conjure'),
  pattern = {"*.rkt"},
  callback = function() log.vsplit() end,
})
