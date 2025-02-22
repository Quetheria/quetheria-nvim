-- Exit if the language server isn't available
if vim.fn.executable('nixd') ~= 1 then
  return
end

local root_files = {
  'flake.nix',
  'default.nix',
  'shell.nix',
  '.git',
}

vim.lsp.start {
  filetypes = { "nix" },
  name = 'nixd',
  cmd = { 'nixd' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = { nixd = { formatting = { command = "alejandra" }, }, },
}
