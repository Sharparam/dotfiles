[
  ;; [ 'tpope/vim-commentary' ]
  ;; [ 'tpope/vim-endwise' ]
  [ "tpope/vim-repeat" ]
  ;; [ "tpope/vim-surround" ]

  { 1 "numToStr/Comment.nvim"
    :dependencies "JoosepAlviste/nvim-ts-context-commentstring"
    :opts (fn []
      (let [integration (require :ts_context_commentstring.integrations.comment_nvim)]
        { :pre_hook (integration.create_pre_hook) }))}

  { 1 "ggandor/leap.nvim"
    :dependencies "tpope/vim-repeat"
    :config (fn []
      (let [leap (require :leap)]
        (leap.add_default_mappings)
        (set leap.opts.highlight_unlabeled_phase_one_targets true)))}
  { 1 "ggandor/flit.nvim"
    :dependencies "ggandor/leap.nvim"
    :opts { :multiline true }}

  { 1 "folke/which-key.nvim"
    :event :VeryLazy
    :init (fn []
      (set vim.o.timeout true)
      (set vim.o.timeoutlen 500))
    :opts {}
    :config (fn [_ opts]
      (let [wk (require :which-key)]
        (wk.setup opts))
      (require :config.which_key))}
]
