[
  {
    1 :akinsho/bufferline.nvim
    :version :*
    :dependencies :nvim-tree/nvim-web-devicons
    :event :VeryLazy
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>bP" 2 "<Cmd>BufferLineTogglePin<CR>" :desc "Toggle pin"}
      { 1 "<Leader>bU" 2 "<Cmd>BufferLineGroupClose ungrouped<CR>" :desc "Delete unpinned buffers"}
      { 1 "<Leader>bb" 2 "<Cmd>BufferLinePick<CR>" :desc "Pick buffer"}
      { 1 "<Leader>bD" 2 "<Cmd>BufferLinePickClose<CR>" :desc "Pick buffer to close"}]

    :opts (fn []
           (let
             [
               bufferline (require :bufferline)
               icons (require :config.icons)
               diag
               {
                 :error icons.diagnostics.Error
                 :warning icons.diagnostics.Warn
                 :hint icons.diagnostics.Hint
                 :info icons.diagnostics.Info}

               diag_fb icons.diagnostics.Info]

             {
               :options
               {
                 :mode :buffers
                 :style_preset [ bufferline.style_preset.no_italic]
                 :themable true
                 :numbers :both
                 :middle_mouse_command "bdelete! %d"
                 :diagnostics :nvim_lsp
                 :diagnostics_indicator (fn [_count _level diagnostics-dict _context]
                                         (var s " ")
                                         (each [e n (pairs diagnostics-dict)]
                                           (set s (.. s n (or (. diag e) diag_fb))))
                                         s)
                 :offsets
                 [
                   {
                     :filetype :NvimTree
                     :text "File Explorer"
                     :text_align :center
                     :highlight :Directory
                     :separator true}]


                 :color_icons true
                 :show_buffer_icons true
                 :show_buffer_close_icons false
                 :show_close_icon false
                 :show_tab_indicators true
                 :show_duplicate_prefix true
                 :separator_style :thin
                 :hover
                 {
                   :enabled true
                   :delay 200
                   :reveal [ :close]}}


               :highlights ((. (require :catppuccin.groups.integrations.bufferline) :get))}))
                 ;; background = muted,
                 ;; tab = muted,
                 ;; tab_close = muted,
                 ;; close_button = muted,
                 ;; close_button_visible = muted,
                 ;; buffer_visible = muted,
                 ;; numbers = muted,
                 ;; numbers_visible = muted,
                 ;; diagnostic = muted,
                 ;; diagnostic_visible = muted,
                 ;; hint = muted,
                 ;; hint_visible = muted,
                 ;; hint_diagnostic = muted,
                 ;; hint_diagnostic_visible = muted,
                 ;; info = muted,
                 ;; info_visible = muted,
                 ;; info_diagnostic = muted,
                 ;; info_diagnostic_visible = muted,
                 ;; warning = muted,
                 ;; warning_visible = muted,
                 ;; warning_diagnostic = muted,
                 ;; warning_diagnostic_visible = muted,
                 ;; error = muted,
                 ;; error_visible = muted,
                 ;; error_diagnostic = muted,
                 ;; error_diagnostic_visible = muted,
                 ;; duplicate_selected = muted,
                 ;; duplicate_visible = muted,
                 ;; duplicate = muted,
                 ;; separator_visible = muted,
                 ;; separator = muted


    :config (fn [_ opts] ((. (require :bufferline) :setup) opts))}

  {
    1 :nvim-lualine/lualine.nvim
    :dependencies :nvim-tree/nvim-web-devicons
    :event :VeryLazy
    :cond (not vim.g.vscode)
    :opts (fn []
           (let
             [
               icons (require :config.icons)
               utils (require :utils)
               colors
               {
                 "" (utils.fg :Special)
                 :Normal (utils.fg :Special)
                 :Warning (utils.fg :DiagnosticError)
                 :InProgress (utils.fg :DiagnosticWarn)}]


             {
               :options
               {
                 :theme :catppuccin ; :tokyonight, :auto
                 :globalstatus true
                 :disabled_filetypes { :statusline [ :dashboard :alpha]}}

               :sections
               {
                 :lualine_a [ :mode]
                 :lualine_b
                 [
                   { 1 :branch :separator ""}
                   {
                     1 :diff
                     :symbols
                     {
                       :added icons.git.added
                       :modified icons.git.modified
                       :removed icons.git.removed}}]



                 :lualine_c
                 [
                   {
                     1 :diagnostics
                     :symbols
                     {
                       :error icons.diagnostics.Error
                       :warn icons.diagnostics.Warn
                       :info icons.diagnostics.Info}}


                   {
                     1 :filetype
                     :icon_only true
                     :separator ""
                     :padding { :left 1 :right 0}}

                   {
                     1 :filename
                     :path 1
                     :symbols { :modified "  " :readonly "" :unnamed ""}}

                   {
                     1 (fn [] ((. (require :nvim-navic) :get_location)))
                     :cond (fn [] (and package.loaded.nvim-navic ((. (require :nvim-navic) :is_available))))}]



                 :lualine_x
                 [
                   {
                     1 (fn [] (let [noice (require :noice)] (noice.api.status.command.get)))
                     :cond (fn [] (and package.loaded.noice (let [noice (require :noice)] (noice.api.status.command.has))))
                     :color (utils.fg :Statement)}

                   {
                     1 (fn [] (let [noice (require :noice)] (noice.api.status.mode.get)))
                     :cond (fn [] (and package.loaded.noice (let [noice (require :noice)] (noice.api.status.mode.has))))
                     :color (utils.fg :Constant)}

                   {
                     1 (fn [] (let [cpa (require :copilot.api)] (.. icons.kinds.Copilot (or cpa.status.data.message ""))))
                     :cond (fn []
                            (let [(ok clients) (pcall vim.lsp.get_active_clients { :name :copilot :bufnr 0})]
                              (and ok (> (length clients) 0))))
                     :color (fn []
                             (if (not package.loaded.copilot) (lua :return))
                             (let [cpa (require :copilot.api)]
                               (or (. colors cpa.status.data.status) (. colors ""))))}

                   {
                     1 (fn [] (.. "  "  ((. (require :dap) :status))))
                     :cond (fn [] (and package.loaded.dap (~= ((. (require :dap) :status)) "")))
                     :color (utils.fg :Debug)}

                   {
                     1 (. (require :lazy.status) :updates)
                     :cond (. (require :lazy.status) :has_updates)
                     :color (utils.fg :Special)}]


                 :lualine_y
                 [
                   { 1 :encoding :separator ""}
                   :fileformat]

                 :lualine_z
                 [
                   { 1 :progress :separator " " :padding { :left 1 :right 0}}
                   { 1 :location :padding { :left 0 :right 1}}]}


               :extensions [ :lazy]}))}


  {
    1 :nvim-telescope/telescope.nvim
    :tag :0.1.1
    :dependencies [:nvim-lua/plenary.nvim
                   :nvim-telescope/telescope-symbols.nvim]
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<leader>ff" 2 "<cmd>Telescope find_files hidden=true<cr>" :desc "Find files"}
      { 1 "<leader>." 2 "<Leader>ff" :desc "Find files" :remap true}
      { 1 "<leader>gff" 2 "<cmd>Telescope git_files<cr>" :desc "Find Git file"}
      { 1 "<leader><leader>" 2 "<cmd>Telescope git_files<cr>" :desc "Find file in project"}
      { 1 "<leader>sd" 2 "<cmd>Telescope live_grep<cr>" :desc "Search CWD"}
      { 1 "<leader>bB" 2 "<cmd>Telescope buffers<cr>" :desc "List buffers"}
      { 1 "<leader>sm" 2 "<cmd>Telescope marks<cr>" :desc "List marks"}
      { 1 "<leader><cr>" 2 "<cmd>Telescope marks<cr>" :desc "List marks"}
      { 1 "<leader>hn" 2 "<cmd>Telescope notify<cr>" :desc "List notifications"}
      { 1 "<leader>cj" 2 "<cmd>Telescope treesitter<cr>" :desc "List treesitter objects"}
      { 1 "<leader>clGb" 2 "<cmd>Telescope lsp_document_symbols<cr>" :desc "Find symbols in buffer"}
      { 1 "<leader>clGc" 2 "<cmd>Telescope lsp_incoming_calls<cr>" :desc "List incoming calls"}
      { 1 "<leader>clGC" 2 "<cmd>Telescope lsp_outgoing_calls<cr>" :desc "List outgoing calls"}
      { 1 "<leader>clGe" 2 "<cmd>Telescope diagnostics bufnr=0<cr>" :desc "Show diagnostics"}
      { 1 "<leader>clGE" 2 "<cmd>Telescope diagnostics<cr>" :desc "Show all diagnostics"}
      { 1 "<leader>clGg" 2 "<cmd>Telescope lsp_definitions<cr>" :desc "Find definitions"}
      { 1 "<leader>clGi" 2 "<cmd>Telescope lsp_implementations<cr>" :desc "Find implementations"}
      { 1 "<leader>clGr" 2 "<cmd>Telescope lsp_references<cr>" :desc "Find references"}
      { 1 "<leader>clGs" 2 "<cmd>Telescope lsp_workspace_symbols<cr>" :desc "Find symbols in workspace"}
      { 1 "<leader>clGS" 2 "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" :desc "Find symbols in workspace (dynamic)"}
      { 1 "<leader>clGt" 2 "<cmd>Telescope lsp_type_definitions<cr>" :desc "Find type definitions"}
      { 1 "<leader>hbB" 2 "<cmd>Telescope keymaps<cr>" :desc "List normal keymaps"}
      { 1 "<leader>ib" 2 "<cmd>Telescope builtin<cr>" :desc "Built-in pickers"}
      { 1 "<leader>id" 2 "<cmd>Telescope symbols<cr>" :desc "Symbols from data"}
      { 1 "<leader>iP" 2 "<cmd>Telescope planets<cr>" :desc "Planets"}]


    :config (fn [_ opts]
             (let [telescope (require :telescope)]
               (telescope.setup)
               (telescope.load_extension :notify)))}

  {
    1 :stevearc/oil.nvim
    :dependencies :nvim-tree/nvim-web-devicons
    :cond (not vim.g.vscode)
    :opts { :columns [ :permissions :siz :mtime :icon]}}

  {
    1 :nvim-tree/nvim-tree.lua
    :dependencies :nvim-tree/nvim-web-devicons
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>op" 2 "<Cmd>NvimTreeToggle<CR>" :desc "Toggle tree"}
      { 1 "<Leader>oP" 2 "<Cmd>NvimTreeFindFile<CR>" :desc "Find file in tree"}]

    :opts {}}

  { 1 :stevearc/dressing.nvim :cond (not vim.g.vscode) :opts {}}
  {
    1 :folke/noice.nvim
    :dependencies [ :MunifTanjim/nui.nvim :rcarriga/nvim-notify]
    :cond (not vim.g.vscode)
    :opts
    {
      :lsp
      {
        :override
        {
          :vim.lsp.util.convert_input_to_markdown_lines true
          :vim.lsp.util.stylize_markdown true
          :cmp.entry.get_documentation true}}


      :presets
      {
        :bottom_search true
        :command_palette true
        :long_message_to_split true
        :inc_rename false
        :lsp_doc_border false}}}



  {
    1 :folke/trouble.nvim
    :dependencies [ :nvim-tree/nvim-web-devicons]
    :cond (not vim.g.vscode)
    :keys
    [
      { 1 "<Leader>cxx" 2 "<Cmd>TroubleToggle<CR>" :desc "Diagnostics"}
      { 1 "<Leader>cxw" 2 "<Cmd>TroubleToggle workspace_diagnostics<CR>" :desc "Workspace diagnostics"}
      { 1 "<Leader>cxd" 2 "<Cmd>TroubleToggle document_diagnostics<CR>" :desc "Document diagnostics"}
      { 1 "<Leader>cxq" 2 "<Cmd>TroubleToggle quickfix<CR>" :desc "Quickfix items"}
      { 1 "<Leader>cxl" 2 "<Cmd>TroubleToggle loclist<CR>" :desc "Items from location list"}]

    :opts {}}

  {
    1 :rcarriga/nvim-notify
    :cond (not vim.g.vscode)
    :main :notify
    :opts { :render :compact}
    :config (fn [_ opts] ((. (require :notify) :setup) opts))}

  {
    1 :Bekaboo/deadcolumn.nvim
    :cond (not vim.g.vscode)
    :opts
    {
      :scope :line ; or :buffer
      :modes [
        ;; :n :no :nov :noV
              :niI :niR :niV
              :i :ic :ix
              :R :Rc :Rx :Rv :Rvc :Rvx]

      ;; :modes (fn [] true)
      :blending {
                 :threshold 0.75
                 :colorcode :#000000
                 :hlgroup [ :Normal :background]}

      :warning {
                :alpha 0.4
                :offset 0
                :colorcode :#FF0000
                :hlgroup [ :Error :foreground]}

      :extra { :follow_tw "+1"}}}]


  ;; {
  ;;   1 :ecthelionvi/NeoColumn.nvim
  ;;   :event :VeryLazy
  ;;   :keys {
  ;;     { 1 "<Leader>tc" 2 "<Cmd>ToggleNeoColumn<CR>" :desc "Toggle column" }
  ;;   }
  ;;   :opts { :fg_color :#FF0000 :bg_color :#00FF00 :NeoColumn [ :80 :120 ] }
  ;; }

