[
  {1 :echasnovski/mini.ai :version false :config true}
  {1 :echasnovski/mini.bracketed :version false :config true}
  {1 :echasnovski/mini.bufremove :version false :config true}
  ;; {
  ;;   1 :echasnovski/mini.comment
  ;;   :version false
  ;;   :dependencies :JoosepAlviste/nvim-ts-context-commentstring
  ;;   :opts
  ;;   {
  ;;     :options
  ;;     {
  ;;       :custom_commentstring
  ;;       (fn []
  ;;         (or ((. (require :ts_context_commentstring.internal) :calculate_commentstring)) vim.bo.commentstring))
  ;;     }
  ;;   }
  ;; }
  {
    1 :echasnovski/mini.indentscope
    :version false
    :cond (not vim.g.vscode)
    :opts
    (fn []
      (let [indentscope (require :mini.indentscope)]
        { :draw { :animation (indentscope.gen_animation.none)}}))}

  { 1 :echasnovski/mini.pairs :version false :config true}
  {
    1 :echasnovski/mini.surround
    :version false
    :opts
    {
      :mappings
      {
        :add :gza
        :delete :gzd
        :find :gzf
        :find_left :gzF
        :highlight :gzh
        :replace :gzr
        :update_n_lines :gzn
        :suffix_last :l
        :suffix_next :n}}}



  {
    1 :echasnovski/mini.trailspace
    :version false
    :keys
    {
      {
        1 "<Leader>cw"
        2 (fn [] ((. (require :mini.trailspace) :trim)))
        :desc "Trim trailing whitespace"}

      {
        1 "<Leader>cW"
        2 (fn [] ((. (require :mini.trailspace) :trim_last_lines)))
        :desc "Trim trailing empty lines"}}}]
