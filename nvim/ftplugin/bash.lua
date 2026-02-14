-- Exit if the language server isn't available
if vim.fn.executable('bash-language-server') ~= 1 then
  return
end


vim.lsp.start {
  filetypes={ 'bash', 'sh' },
  name = 'bashls',
  cmd = { 'bash-language-server' },
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = { },
}
