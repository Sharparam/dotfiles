(local utils (require :utils))

(utils.create-augroup
  [[ "BufEnter,FocusGained,InsertLeave" :* "set relativenumber"]
   [ "BufLeave,FocusLost,InsertEnter" :* "set norelativenumber"]]
  :numbertoggle)

(require :config.autocmds.colorcolumn)
