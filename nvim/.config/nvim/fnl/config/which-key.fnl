(local wk (require :which-key))

(wk.register
  {
    :b {:name :+buffer
        "[" ["<Cmd>bprevious<CR>" "Previous buffer"]
        :p ["<Cmd>bprevious<CR>" "Previous buffer"]
        "]" ["<Cmd>bnext<CR>" "Next buffer"]
        :n ["<Cmd>bnext<CR>" "Next buffer"]
        :d ["<Cmd>bdelete<CR>" "Kill buffer"]
        :k ["<Cmd>bdelete<CR>" "Kill buffer"]
        :K ["<Cmd>%bdelete<CR>" "Kill all buffers"]
        :s ["<Cmd>w<CR>" "Save buffer"]
        :S ["<Cmd>wa<CR>" "Save all buffers"]
        :u ["<Cmd>w !sudo tee %<CR>" "Save buffer as root"]
        :y ["<Cmd>%y<CR>" "Yank buffer"]}
    :c
    {
      :name :+code
      :d [ vim.lsp.buf.definition "Jump to definition"]
      :D [ vim.lsp.buf.references "Jump to references"]
      :f [ (fn [] (vim.lsp.buf.format { :async true })) "Format buffer"]
      :i [ vim.lsp.buf.implementation "Find implementations"]
      :k [ vim.lsp.buf.hover "Show help"]
      :l
      {
        :name :+lsp
        :=
        {
          :name :+formatting
          := [ (fn [] (vim.lsp.buf.format { :async true })) "Format buffer"]}

        :a
        {
          :name "+code actions"
          :a [ vim.lsp.buf.code_action "Code actions"]}

        :d
        {
          :name :+diagnostics
          :l [ vim.diagnostic.open_float "Show diagnostics window"]
          :n [ vim.diagnostic.goto_next "Go to next diagnostic"]
          :p [ vim.diagnostic.goto_prev "Go to previous diagnostic"]}

        :f
        {
          :name :+folders
          :a [ vim.lsp.buf.add_workspace_folder "Add workspace folder"]
          :l [ vim.lsp.buf.list_workspace_folders "List workspace folders"]
          :r [ vim.lsp.buf.remove_workspace_folder "Remove workspace folder"]}

        :g
        {
          :name :+goto
          :a [ vim.lsp.buf.workspace_symbol "Find symbol in workspace"]
          :c [ vim.lsp.buf.incoming_calls "Find incoming calls"]
          :C [ vim.lsp.buf.outgoing_calls "Find outgoing calls"]
          :d [ vim.lsp.buf.declaration "Find declarations"]
          :g [ vim.lsp.buf.definition "Find definitions"]
          :i [ vim.lsp.buf.implementation "Find implementations"]
          :r [ vim.lsp.buf.references "Find references"]
          :t [ vim.lsp.buf.type_definition "Find type definition"]}

        :G { :name :+peek}
        :h
        {
          :name :+help
          :s [ vim.lsp.buf.signature_help "Show signature help"]}

        :r
        {
          :name :+refactor
          :r [ vim.lsp.buf.rename "Rename"]}

        :t
        {
          :name :+toggle
          :s [ vim.lsp.buf.signature_help "Show signature help"]}}

        ;; :w { :name :+workspaces }

      :r [ vim.lsp.buf.rename "Rename"]
      :t [ vim.lsp.buf.type_definition "Find type definition"]
      :x { :name :+Trouble}}

    :f { :name :+file}
    :g
    {
      :name :+git
      :f { :name :+find}
      :T { :name :+toggle}}

    :h
    {
      :name :+help
      :b
      {
        :name :+bindings
        :b [ "<Cmd>WhichKey<CR>" "Show all mappings"]}}


    :i { :name :insert}
    :o { :name :open}
    :s { :name :search}
    :w
    {:name :window
     :+ ["<C-w>+" "Increase height"]
     :- ["<C-w>-" "Decrease height"]
     :< ["<C-w><" "Decrease width"]
     := ["<C-w>=" "Balance"]
     :_ ["<C-w>_" "Set height"]
     :> ["<C-w>>" "Increase width"]
     :b ["<C-w>b" "Go to bottom"]
     :c ["<Cmd>close<CR>" "Close"]
     :C ["<Cmd>close!<CR>" "Close discard changes"]
     :d ["<C-w>d" "Split to definition"]
     :f ["<C-w>f" "Split to file"]
     :F ["<C-w>F" "Split to file:line"]
     :g
     {:name :prefix
      "<C-]>" ["<C-w>g<C-]>" "Split and tag jump"]
      "]" ["<C-w>g]" "Split and tag select"]
      "}" ["<C-w>g}" "Preview tag jump"]
      :f ["<C-w>gf" "Edit file in new tab page"]
      :F ["<C-w>gF" "Edit file:line in new tab page"]
      :t ["<Cmd>tabnext<CR>" "Next tab page"]
      :T ["<Cmd>tabprevious<CR>" "Previous tab page"]
      "<Tab>" ["<Cmd>tablast<CR>" "Last accessed tab page"]}
     :h ["<C-w>h" "Go left"]
     :H ["<C-w>H" "Move left"]
     :i ["<C-w>i" "Split to declaration"]
     :j ["<C-w>j" "Go down"]
     :J ["<C-w>J" "Move down"]
     :k ["<C-w>k" "Go up"]
     :K ["<C-w>K" "Move up"]
     :l ["<C-w>l" "Go right"]
     :n ["<C-w>n" "New"]
     :o ["<Cmd>only<CR>" "Close all but current"]
     :p ["<C-w>p" "Go to previous"]
     :P ["<C-w>P" "Go to preview"]
     :q ["<Cmd>quit<CR>" "Quit"]
     :Q ["<Cmd>quit!<CR>" "Quit discard changes"]
     :r ["<C-w>r" "Rotate downwards"]
     :R ["<C-w>R" "Rotate upwards"]
     :s ["<C-w>s" "Split horizontal"]
     :S ["<C-w>S" "Split horizontal"]
     :t ["<C-w>t" "Go to top"]
     :T ["<C-w>T" "Move to new tab page"]
     :v ["<C-w>v" "Split vertical"]
     :w ["<C-w>w" "Go to next (wrap around)"]
     :W ["<C-w>W" "Previous (wrap around)"]
     :x ["<C-w>x" "Exchange"]
     :z ["<C-w>z" "Close preview"]
     "}" ["<C-w>}" "Show tag in preview"]
     "<Down>" ["<C-w>j" "Go down"]
     "<Up>" ["<C-w>k" "Go up"]
     "<Left>" ["<C-w>h" "Go left"]
     "<Right>" ["<C-w>l" "Go right"]}}

  {:prefix "<Leader>"})

(wk.register {:g {:name :git}} {:mode :v :prefix "<Leader>"})

;; Manually added bindings that which-key doesn't detect
(wk.register
  {:gt ["Next tab page"]
   :gT ["Previous tab page"]
   "g<Tab>" ["Last accessed tab page"]})

(wk.register
  {:g
    {:name :prefix
     :t ["Next tab page"]
     :T ["Previous tab page"]
     "<Tab>" ["Last accessed tab page"]}}
  {:prefix "<C-w>"})
