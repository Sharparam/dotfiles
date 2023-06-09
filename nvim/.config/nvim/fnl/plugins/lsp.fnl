(local
  wanted-servers
  [
    :ansiblels                       ;; Ansible
    :bicep                           ;; Bicep
    :dockerls                        ;; Docker
    :docker_compose_language_service ;; Docker Compose
    :fennel_language_server          ;; Fennel
    :html                            ;; HTML
    :jsonls                          ;; JSON
    :tsserver                        ;; JavaScript/TypeScript
    :lua_ls                          ;; Lua
    :perlnavigator                   ;; Perl
    :raku_navigator                  ;; Raku
    :solargraph                      ;; Ruby
    :rust_analyzer                   ;; Rust
    :taplo                           ;; TOML
    :vimls                           ;; VimL
    :lemminx                         ;; XML
    :yamlls])                          ;; YAML


[
  {
    1 :VonHeikemen/lsp-zero.nvim
    :branch :v2.x
    :dependencies
    [
      [ :neovim/nvim-lspconfig]
      { 1 :williamboman/mason.nvim :build ":MasonUpdate" :cmd :Mason :config true}
      { 1 :williamboman/mason-lspconfig.nvim :dependencies :williamboman/mason.nvim}
      {
        1 :hrsh7th/nvim-cmp
        :version false
        :dependencies
        [
          [:hrsh7th/cmp-nvim-lsp]
          [:hrsh7th/cmp-buffer]
          [:hrsh7th/cmp-path]
          [:hrsh7th/cmp-cmdline]
          [:L3MON4D3/LuaSnip]
          [:saadparwaiz1/cmp_luasnip]
          [:PaterJason/cmp-conjure]]}


      [ :hrsh7th/cmp-nvim-lsp]
      {
        1 :zbirenbaum/copilot.lua
        :build ":Copilot auth"
        :cmd :Copilot
        :opts { :suggestion { :enabled false } :panel { :enabled false}}}

      {
        1 :zbirenbaum/copilot-cmp
        :dependencies :zbirenbaum/copilot.lua
        :main :copilot_cmp
        :opts {}
        :config
        (fn [_ opts]
          (let [copilot-cmp (require :copilot_cmp) utils (require :utils)]
            (copilot-cmp.setup opts)
            (utils.on-attach
              (fn [client]
                (if (= client.name :copilot) (copilot-cmp._on_insert_enter {}))))))}

      {
        1 :L3MON4D3/LuaSnip
        :build (fn []
                (if (jit.os:find :Windows)
                  nil
                  "echo \"NOTE: jsregexp optional, failure to build is OK\"; make install_jsregexp"))}

      [ :rafamadriz/friendly-snippets]
      { 1 :folke/neoconf.nvim :config true}
      { 1 :folke/neodev.nvim :dependencies :hrsh7th/nvim-cmp :opts {}}
      { 1 :jose-elias-alvarez/null-ls.nvim :dependencies :williamboman/mason.nvim}
      {
        1 :jay-babu/mason-null-ls.nvim
        :event [ :BufReadPre :BufNewFile]
        :dependencies [ :williamboman/mason.nvim :jose-elias-alvarez/null-ls.nvim]}]


    :config
    (fn [_ opts]
      (let [lsp ((. (require :lsp-zero) :preset) {})]
        (lsp.on_attach
          (fn [client bufnr]
           (lsp.default_keymaps { :buffer bufnr})
           (let [map (fn [m l r d] (vim.keymap.set m l r { :buffer bufnr :desc d}))]
             (map :n :gI vim.lsp.buf.implementation "Go to implementation"))))
        (lsp.format_mapping
          :gq
          {
            :format_opts { :async true :timeout_ms 10000}
            :servers
            {
              :null-ls
              [
                :javascript :typescript
                :lua :fennel
                :ruby
                :c :cpp
                :rust
                :py
                :sh :bash :zsh]}})



        (lsp.setup)
        (let [null-ls (require :null-ls)]
          (null-ls.setup
            {
              :sources
              [null-ls.builtins.formatting.fnlfmt]}))
                ;; null-ls.builtins.formatting.prettier
                ;; null-ls.builtins.formatting.eslint


        ((. (require :mason-null-ls) :setup)
         { :ensure_installed nil :automatic_installation true :handlers []})
        ((. (require :luasnip.loaders.from_vscode) :lazy_load))
        (let [cmp (require :cmp) cmp-action ((. (require :lsp-zero) :cmp_action))]
          (cmp.setup
            {
              :snippet { :expand (fn [args] ((. (require :luasnip) :lsp_expand) args.body))}
              :mapping
              {
                "<C-n>" (cmp.mapping.select_next_item { :behavior cmp.SelectBehavior.Insert})
                "<C-p>" (cmp.mapping.select_prev_item { :behavior cmp.SelectBehavior.Insert})
                "<C-u>" (cmp.mapping.scroll_docs -4)
                "<C-d>" (cmp.mapping.scroll_docs 4)

                ;; `Enter` key to confirm completion
                "<CR>" (cmp.mapping.confirm { :select false})
                "<S-CR>" (cmp.mapping.confirm { :behavior cmp.ConfirmBehavior.Replace :select false})
                "<Tab>" (cmp.mapping.confirm { :select true})
                "<S-Tab>" (cmp.mapping.confirm { :behavior cmp.ConfirmBehavior.Replace :select true})

                ;; Ctrl+Space to trigger completion menu
                "<C-Space>" (cmp.mapping.complete)

                "<C-e>" (cmp.mapping.abort)

                ;; Navigate between snippet placeholder
                "<C-f>" (cmp-action.luasnip_jump_forward)
                "<C-b>" (cmp-action.luasnip_jump_backward)}

              :sources
              (cmp.config.sources
                [
                  { :name :copilot :group_index 2}
                  { :name :conjure}
                  { :name :nvim_lsp}
                  { :name :luasnip}
                  { :name :buffer}
                  { :name :path}
                  { :name :cmdline}])

              :sorting
              {
                :priority_weight 2
                :comparators
                [
                  (. (require :copilot_cmp.comparators) :prioritize)
                  cmp.config.compare.offset
                  ;; cmp.config.compare.scopes
                  cmp.config.compare.exact
                  cmp.config.compare.score
                  cmp.config.compare.recently_used
                  cmp.config.compare.locality
                  cmp.config.compare.kind
                  cmp.config.compare.sort_text
                  cmp.config.compare.length
                  cmp.config.compare.order]}


              :formatting
              {
                :format (fn [entry item]
                         (let [icons (. (require :config.icons) :kinds)]
                           (if (. icons item.kind) (set item.kind (.. (. icons item.kind) item.kind))))
                         (let
                           [
                             smap
                             {
                               :buffer "[BUF]"
                               :nvim_lsp "[LSP]"
                               :luasnip "[SNP]"
                               :nvim_lua "[LUA]"
                               :latex_symbols "[LTX]"
                               :path "[PTH]"
                               :cmdline "[CMD]"
                               :copilot "[COP]"
                               :conjure "[CNJ]"}]


                           (set item.menu (. smap entry.source.name)))
                         item)}

              :experimental { :ghost_text { :hl_group :NonText}}}))))}]



