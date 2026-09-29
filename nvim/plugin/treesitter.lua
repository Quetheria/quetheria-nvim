if vim.g.did_load_treesitter_plugin then
  return
end
vim.g.did_load_treesitter_plugin = true

local configs = require('nvim-treesitter.config')
vim.g.skip_ts_context_comment_string_module = true

---@diagnostic disable-next-line: missing-fields
configs.setup {
  -- ensure_installed = 'all',
  -- auto_install = false, -- Do not automatically install missing parsers when entering buffer
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KiB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobject, similar to targets.vim
      lookahead = true,
      keymaps = {
        ['af'] = { query='@function.outer', desc="select outer function" },
        ['if'] = { query='@function.inner', desc="select inner function" },
        ['ac'] = { query='@class.outer', desc="select outer class" },
        ['ic'] = { query='@class.inner', desc="select inner class" },
        ['aC'] = { query='@call.outer', desc="select outer call" },
        ['iC'] = { query='@call.inner', desc="select inner call" },
        ['a#'] = { query='@comment.outer', desc="select outer comment" },
        ['i#'] = { query='@comment.inner', desc="select inner comment" },
        ['ai'] = { query='@conditional.outer', desc="select outer conditional" },
        ['ii'] = { query='@conditional.inner', desc="select inner conditional" },
        ['al'] = { query='@loop.outer', desc="select outer loop" },
        ['il'] = { query='@loop.inner', desc="select inner loop" },
        ['aP'] = { query='@parameter.outer', desc="select outer parameter" },
        ['iP'] = { query='@parameter.inner', desc="select inner parameter" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@parameter.inner'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@function.inner'] = 'V', -- linewise
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']P'] = '@parameter.outer',
      },
      goto_next_end = {
        [']m'] = '@function.outer',
        [']P'] = '@parameter.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[P'] = '@parameter.outer',
      },
      goto_previous_end = {
        ['[m'] = '@function.outer',
        ['[P'] = '@parameter.outer',
      },
    },
    nsp_interop = {
      enable = true,
      peek_definition_code = {
        ['df'] = '@function.outer',
        ['dF'] = '@class.outer',
      },
    },
  },
}

require('treesitter-context').setup {
  max_lines = 3,
}

require('ts_context_commentstring').setup()

-- Tree-sitter based folding
-- vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
