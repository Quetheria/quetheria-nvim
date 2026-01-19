
-- Exit if the language server isn't available
if vim.fn.executable('ccls') ~= 1 then
  return
end

local root_files = {
  'compile_commands.json',
  'compile_flags.txt',
'.git',
}

vim.lsp.start {
  filetypes={ 'c', 'cpp' },
  name = 'ccls',
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  cmd = { 'ccls' },
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = { },
}


