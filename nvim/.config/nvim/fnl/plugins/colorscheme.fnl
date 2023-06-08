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

[
  {
    1 :folke/tokyonight.nvim
    :lazy false
    :priority 1000
    :opts
    {
      :style :night
      :transparent true
      :styles
      {
        :comments { :italic true }
        :sidebars :dark
        :floats :dark
      }
      :sidebars [ :NvimTree :qf :help :lazy ]
      :on_highlights
      (fn [hl c]
        (set hl.NotifyBackground { :fg c.fg :bg :#000000 }))
    }
    :config
    (fn [_ opts]
      (require :config.colorscheme)
      ((. (require :tokyonight) :setup) opts)
      (vim.cmd "colorscheme tokyonight"))
  }
]
