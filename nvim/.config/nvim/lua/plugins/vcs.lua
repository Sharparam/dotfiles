return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Leader>gTs', '<Cmd>Gitsigns toggle_signs<CR>', desc = 'Toggle signs' },
      { '<Leader>gTn', '<Cmd>Gitsigns toggle_numhl<CR>', desc = 'Toggle num highlight' },
      { '<Leader>gTl', '<Cmd>Gitsigns toggle_linehl<CR>', desc = 'Toggle line highlight' },
      { '<Leader>gTw', '<Cmd>Gitsigns toggle_word_diff<CR>', desc = 'Toggle word diff' },
      { '<Leader>gTb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', desc = 'Toggle current line blame' },
      { '<Leader>gTd', '<Cmd>Gitsigns toggle_deleted<CR>', desc = 'Toggle deleted' },
      { '<Leader>g]', '<Cmd>Gitsigns next_hunk<CR>', desc = 'Jump to next hunk' },
      { '<Leader>g[', '<Cmd>Gitsigns prev_hunk<CR>', desc = 'Jump to previous hunk' },
      { '<Leader>gs', '<Cmd>Gitsigns stage_hunk<CR>', desc = 'Stage hunk' },
      { '<Leader>gr', '<Cmd>Gitsigns reset_hunk<CR>', desc = 'Reset hunk' },
      { '<Leader>gu', '<Cmd>Gitsigns undo_stage_hunk<CR>', desc = 'Undo stage hunk' },
      { '<Leader>gS', '<Cmd>Gitsigns stage_buffer<CR>', desc = 'Stage buffer' },
      { '<Leader>gR', '<Cmd>Gitsigns reset_buffer<CR>', desc = 'Reset buffer' },
      {
        '<Leader>gs',
        function() require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        mode = 'v',
        desc = 'Stage selection'
      },
      {
        '<Leader>gr',
        function() require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        mode = 'v',
        desc = 'Reset selection'
      },
      {
        '<Leader>gB',
        function() require('gitsigns').blame_line { full = true } end,
        desc = 'Blame line'
      },
      { '<Leader>gd', '<Cmd>Gitsigns diffthis<CR>', desc = 'Diff this' }
    },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- map('n', ']c', function()
        --   if vim.wo.diff then return ']c' end
        --   vim.schedule(function() gs.next_hunk() end)
        --   return '<Ignore>'
        -- end, { expr = true, desc = 'Next hunk' })
        -- map('n', '[c', function()
        --   if vim.wo.diff then return '[c' end
        --   vim.schedule(function() gs.prev_hunk() end)
        --   return '<Ignore>'
        -- end, { expr = true, desc = 'Previous hunk' })

        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
      end
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
    end
  }
}
