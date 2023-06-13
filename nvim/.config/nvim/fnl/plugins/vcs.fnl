[
  {
    1 :lewis6991/gitsigns.nvim
    :event :VeryLazy
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>gTs" 2 "<Cmd>Gitsigns toggle_signs<CR>" :desc "Toggle signs" }
      { 1 "<Leader>gTn" 2 "<Cmd>Gitsigns toggle_numhl<CR>" :desc "Toggle num highlight" }
      { 1 "<Leader>gTl" 2 "<Cmd>Gitsigns toggle_linehl<CR>" :desc "Toggle line highlight" }
      { 1 "<Leader>gTw" 2 "<Cmd>Gitsigns toggle_word_diff<CR>" :desc "Toggle word diff" }
      { 1 "<Leader>gTb" 2 "<Cmd>Gitsigns toggle_current_line_blame<CR>" :desc "Toggle current line blame" }
      { 1 "<Leader>gTd" 2 "<Cmd>Gitsigns toggle_deleted<CR>" :desc "Toggle deleted" }
      { 1 "<Leader>g]" 2 "<Cmd>Gitsigns next_hunk<CR>" :desc "Jump to next hunk" }
      { 1 "<Leader>g[" 2 "<Cmd>Gitsigns prev_hunk<CR>" :desc "Jump to previous hunk" }
      { 1 "<Leader>gs" 2 "<Cmd>Gitsigns stage_hunk<CR>" :desc "Stage hunk" }
      { 1 "<Leader>gr" 2 "<Cmd>Gitsigns reset_hunk<CR>" :desc "Reset hunk" }
      { 1 "<Leader>gu" 2 "<Cmd>Gitsigns undo_stage_hunk<CR>" :desc "Undo stage hunk" }
      { 1 "<Leader>gS" 2 "<Cmd>Gitsigns stage_buffer<CR>" :desc "Stage buffer" }
      { 1 "<Leader>gR" 2 "<Cmd>Gitsigns reset_buffer<CR>" :desc "Reset buffer" }
      {
        1 "<Leader>gs"
        2 (fn []
          ((. (require :gitsigns) :stage_hunk) [ (vim.fn.line :.) (vim.fn.line :v) ]))
        :mode :v
        :desc "Stage selection"
      }
      {
        1 "<Leader>gr"
        2 (fn []
          ((. (require :gitsigns) :reset_hunk) [ (vim.fn.line :.) (vim.fn.line :v) ]))
        :mode :v
        :desc "Reset selection"
      }
      {
        1 "<Leader>gB"
        2 (fn []
          ((. (require :gitsigns) :blame_line) { :full true }))
        :desc "Blame line"
      }
      { 1 "<Leader>gd" 2 "<Cmd>Gitsigns diffthis<CR>" :desc "Diff this" }
    ]
    :opts
    {
      :on_attach
      (fn [bufnr]
        (let
          [
            gs package.loaded.gitsigns
            map (fn [mode l r opts]
              (let [opts (or opts {})]
                (set opts.buffer bufnr)
                (vim.keymap.set mode l r opts)))
          ]
          (map [:o :x] :ih ":<C-U>Gitsigns select_hunk<CR>" { :desc "Select hunk" })))
    }
    :config (fn [_ opts] ((. (require :gitsigns) :setup) opts))
  }
]
