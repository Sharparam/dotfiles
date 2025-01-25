-- :fennel:1686361833
local utils = require("utils")
utils["create-augroup"]({{"BufEnter,FocusGained,InsertLeave", "*", "set relativenumber"}, {"BufLeave,FocusLost,InsertEnter", "*", "set norelativenumber"}}, "numbertoggle")
require("config.autocmds.colorcolumn")
return require("config.autocmds.fennel")