local keymap = vim.keymap.set

keymap('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
keymap('n', '<A-.>', '<Cmd>BufferNext<CR>')

keymap('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
keymap('n', '<A->>', '<Cmd>BufferMoveNext<CR>')

--- Goto buffer in position...
keymap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 2<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 3<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 4<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 5<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 6<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 7<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 8<CR>')
keymap('n', '<A-1>', '<Cmd>BufferGoto 9<CR>')
keymap('n', '<A-0>', '<Cmd>BufferLast<CR>')

--- Pin/unpin buffer
keymap('n', '<A-p>', '<Cmd>BufferPin<CR>')
keymap('n', '<A-P>', '<Cmd>BufferGotoPinned<CR>')

--- Goto pinned/unpinned buffer
---                          :BufferGotoPinned
---                          :BufferGotoUnpinned

--- Close buffer
keymap('n', '<A-c>', '<Cmd>BufferClose<CR>')
--- Restore buffer
keymap('n', '<A-s-c>', '<Cmd>BufferRestore<CR>')

--- Wipeout buffer
---                          :BufferWipeout
--- Close commands
---                          :BufferCloseAllButCurrent
---                          :BufferCloseAllButVisible
---                          :BufferCloseAllButPinned
---                          :BufferCloseAllButCurrentOrPinned
---                          :BufferCloseBuffersLeft
---                          :BufferCloseBuffersRight

--- Magic buffer-picking mode
keymap('n', '<C-p>', '<Cmd>BufferPick<CR>')
keymap('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>')

--- Sort automatically by...
keymap('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
keymap('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>')
keymap('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
keymap('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
keymap('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>')

require 'barbar'.setup {
  icons = {
    gitsigns = {
      added = { enabled = false, icon = '+' },
      changed = { enabled = false, icon = '~' },
    },
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true },
    } } }
