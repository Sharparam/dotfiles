(local utils (require :utils))

(utils.create_augroup
  [[ "BufEnter,FocusGained,InsertLeave" :* "set relativenumber"]
   [ "BufLeave,FocusLost,InsertEnter" :* "set norelativenumber"]]
  :numbertoggle)

(require :config.autocmds.colorcolumn)
