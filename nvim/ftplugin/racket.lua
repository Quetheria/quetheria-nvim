
vim.keymap.set("n", "<leader>lam", "aƛ", {silent=true, desc="Insert a [lam]bda after the cursor"})

vim.lsp.start {
  filetypes={ 'racket' },
  name = 'racket-langserver',
  cmd = { 'racket', '-l', 'racket-langserver' },
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = { },
}


