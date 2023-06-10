(local wk (require :which-key))

(wk.register
  {
    :b { :name :+buffer }
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
        :b [ "<Cmd>WhichKey<CR>" "Show all mappings" ]
      }
    }
    :i { :name :+insert }
    :o { :name :+open }
    :s { :name :+search }
  }
  { :prefix "<Leader>" })

(wk.register { :g { :name :+git } } { :mode :v :prefix "<Leader>" })
