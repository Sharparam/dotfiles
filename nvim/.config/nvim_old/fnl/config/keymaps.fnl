;; (local utils (require :utils))

;; Disable arrow keys
;; (each [_ key (pairs ["<Left>" "<Right>" "<Up>" "<Down>"])]
;;   (utils.map "" key "" { :noremap true })
;;   (utils.map :i key "" { :noremap true }))
