(local M {})
(local cmd vim.cmd)

(local
  is-wsl
  (let [output (vim.fn.systemlist "uname -r")]
    (not (not (string.find (or (. output 1) "") "WSL")))))

(set M.is-wsl is-wsl)

(fn M.create-augroup [autocmds name]
  (cmd (.. "augroup " name))
  (cmd :autocmd!)
  (each [_ autocmd (ipairs autocmds)]
    (cmd (.. "autocmd " (table.concat autocmd " "))))
  (cmd "augroup END"))

(fn M.add-rtp [path]
  (set vim.o.rtp (.. vim.o.rtp "," path)))

(fn M.map [mode keys action options]
  (vim.api.nvim_set_keymap mode keys action (or options {})))

(fn M.map-lua [mode keys action options]
  (vim.api.nvim_set_keymap mode keys (.. "<Cmd>lua " action "<CR>") (or options {})))

(fn M.map-buf [mode keys action options buf-nr]
  (let [buf (or buf-nr 0)]
    (vim.api.nvim_buf_set_keymap buf mode keys action (or options {}))))

(fn M.map-lua-buf [mode keys action options buf-nr]
  (let [buf (or buf-nr 0)]
    (vim.api.nvim_buf_set_keymap buf mode keys (.. "<Cmd>lua " action "<CR>") (or options {}))))

(fn M.on-attach [on-attach]
  (vim.api.nvim_create_autocmd
    :LspAttach {
                :callback (fn [args]
                           (let [buffer args.buf
                                 client (vim.lsp.get_client_by_id args.data.client_id)]
                             (on-attach client buffer)))}))


(fn M.has [plugin]
  (let [config (require :lazy.core.config)]
    (~= nil (. config.plugins plugin))))

(fn M.fg [name]
  (let [hl (or (and vim.api.nvim_get_hl (vim.api.nvim_get_hl 0 { : name })) (vim.api.nvim_get_hl_by_name name true))
        fg (or (and hl hl.fg) hl.foreground)]
    (and fg { :fg (string.format "#%06x" fg)})))

(set _G.utils M)
M
