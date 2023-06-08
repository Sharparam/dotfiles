;; [
;;   {
;;     1 :Mofiqul/vscode.nvim
;;     :lazy false
;;     :priority 1000
;;     :opts { :italic_comments true }
;;     :config
;;     (fn [_ opts]
;;       (require :config.colorscheme)
;;       (let [vscode (require :vscode)]
;;         (vscode.setup opts)
;;         (vscode.load)))
;;   }
;; ]

;; [
;;   {
;;     1 :folke/tokyonight.nvim
;;     :lazy false
;;     :priority 1000
;;     :opts
;;     {
;;       :style :night
;;       :transparent true
;;       :styles
;;       {
;;         :comments { :italic true }
;;         :sidebars :dark
;;         :floats :dark
;;       }
;;       :sidebars [ :NvimTree :qf :help :lazy ]
;;       :on_highlights
;;       (fn [hl c]
;;         (set hl.NotifyBackground { :fg c.fg :bg :#000000 }))
;;     }
;;     :config
;;     (fn [_ opts]
;;       (require :config.colorscheme)
;;       ((. (require :tokyonight) :setup) opts)
;;       (vim.cmd "colorscheme tokyonight"))
;;   }
;; ]

[{1 :catppuccin/nvim
  :name :catppuccin
  :lazy false
  :priority 1000
  :opts {:flavour :macchiato
         :transparent_background true
         :show_end_of_buffer true
         :styles {:comments [:italic] :conditionals []}
         :integrations {:cmp true
                        :gitsigns true
                        :leap true
                        :lsp_trouble true
                        :markdown true
                        :mason true
                        :mini true
                        :native_lsp {:enabled true}
                        :noice true
                        :notify true
                        :nvimtree true
                        :telescope true
                        :treesitter true
                        :treesitter_context true
                        :which_key true}}
  :config (fn [_ opts]
            ((. (require :catppuccin) :setup) opts)
            (vim.cmd.colorscheme :catppuccin))}]
