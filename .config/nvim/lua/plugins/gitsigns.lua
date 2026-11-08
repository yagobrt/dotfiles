vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gs = require 'gitsigns'

gs.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gs.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gs.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk' })
    -- normal mode
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hi', gs.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
    map('n', '<leader>hb', gs.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gs.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function() gs.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>hq', gs.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })
    map('n', '<leader>hQ', function() gs.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    -- Toggles
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tw', gs.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })

    -- Text object
    map({ 'o', 'x' }, 'ih', gs.select_hunk, { desc = 'select git hunk' })
  end,
}
