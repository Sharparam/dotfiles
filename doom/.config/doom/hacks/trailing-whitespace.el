;;; trailing-whitespace.el --- Display trailing whitespace  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  Adam Hellberg

;; Author: Adam Hellberg <sharparam@sharparam.com>

(setq-default show-trailing-whitespace t)
(setq show-trailing-whitespace t)

;; Do not highlight trailing whitespace in special buffers
(dolist (hook '(special-mode-hook
                 vterm-mode-hook
                 comint-mode-hook
                 compilation-mode-hook
                 minibuffer-setup-hook))
  (add-hook hook
    #'doom-disable-show-trailing-whitespace-h))

(custom-set-faces!
  '(trailing-whitespace :background unspecified :underline (:color "#cc6666" :style wave)))
