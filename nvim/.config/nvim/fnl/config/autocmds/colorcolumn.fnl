(let
  [config {
           :cs :120
           :gitcommit [ :50 :72]
           :lua :80
           :markdown :80
           :ruby :80}]
  (each [lang opt (pairs config)]
    (let [opt_dest (if (= (type opt) :table) (.. "[" (table.concat opt ", ")"]") opt)]
      (vim.api.nvim_create_autocmd
        :FileType
        {
          :pattern lang
          :callback (fn [] (set vim.opt_local.colorcolumn opt))
          :desc (.. "Set colorcolumn for " lang " files to " opt_desc)}))))
