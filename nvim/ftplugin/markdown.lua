-- Exit if the language server isn't available
if vim.fn.executable('marksman') ~= 1 then
  return
end

vim.lsp.start {
  name = 'marksman',
  filetypes = { "markdown", "markdown.mdx" },
  cmd = { 'marksman', 'server' },
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    marksman = { },
  }
}


