(global-linum-mode t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)

(require 'powerline)

(require 'moe-theme)
(powerline-moe-theme)
(moe-dark)

