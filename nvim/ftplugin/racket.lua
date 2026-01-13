
vim.lsp.start {
  filetypes={ 'racket' },
  name = 'racket-langserver',
  cmd = { 'racket', '-l', 'racket-langserver' },
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = { },
}


