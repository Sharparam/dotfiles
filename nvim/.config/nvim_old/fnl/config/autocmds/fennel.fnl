(local
  set-binds
  (fn [e]
    (let [bufnr e.buf wk (require :which-key)]
      (wk.register
        {:E ["<Cmd>FnlBuffer<CR>" "Eval buffer"]
         :L ["<Cmd>FnlPeek<CR>" "Peek buffer"]
         :O ["<Cmd>FnlGotoOutput<CR>" "Go to output"]}
        {:mode :n :prefix "<LocalLeader>e" :buffer bufnr})
      (wk.register
        {:E ["<Cmd>'<,'>FnlBuffer<CR>" "Eval selection"]
         :L ["<Cmd>'<,'>FnlPeek<CR>" "Peek selection"]}
        {:mode :v :prefix "<LocalLeader>e" :buffer bufnr}))))

(vim.api.nvim_create_autocmd
  :FileType
  {:pattern :fennel
   :callback set-binds
   :desc "Set tangerine mappings in fennel files"})

