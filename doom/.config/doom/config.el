;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Adam Hellberg"
      user-mail-address "sharparam@sharparam.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq my/font-size
  (cond ((eq system-type 'windows-nt) 28)
    (t 16)))

(setq my/font-mode 'caskaydia)

(defun my/adjust-fixed-pitch ()
  (set-face-attribute 'fixed-pitch nil :height 1.0))

(add-hook! '(after-setting-font-hook doom-init-ui-hook after-init-hook server-after-make-frame-hook)
  #'my/adjust-fixed-pitch)

(defun my/cascadia-fonts ()
  (setq
    doom-font (font-spec :family "Cascadia Code" :size 16 :weight 'regular)
    doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18)
    doom-serif-font (font-spec :family "Meta Serif Pro" :size 16)))

(defun my/caskaydia-fonts ()
  (setq
    doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16)
    doom-variable-pitch-font (font-spec :family "Recursive Sans Linear Static" :size 16)
    doom-serif-font (font-spec :family "Recursive Mono Casual Static" :size 16)))

(defun my/triplicate-fonts ()
  (setq
    doom-font (font-spec :family "Triplicate A Code" :size 16 :width 'condensed)
    doom-variable-pitch-font (font-spec :family "Concourse T4" :size 20)
    doom-serif-font (font-spec :family "Equity Text A" :size 18)
    doom-font-increment 4))

(defun my/input-fonts ()
  (setq
    doom-font (font-spec :family "Input Mono Condensed" :size 16 :width 'condensed)
    doom-variable-pitch-font (font-spec :family "Input Sans Condensed" :size 16 :width 'condensed)
    doom-serif-font (font-spec :family "Input Serif Condensed" :size 16 :width 'condensed)
    doom-font-increment 4))
    ;; doom-big-font (font-spec :family "Input Mono Condensed" :size 24))

(defun my/fira-fonts ()
  (setq
    doom-font (font-spec :family "Fira Code" :size 16)
    doom-variable-pitch-font (font-spec :family "Fira Sans" :size 16)
    doom-serif-font (font-spec :family "Meta Serif Pro" :size 16)
    doom-font-increment 4))

(defun my/recursive-fonts ()
  (setq
    doom-font (font-spec :family "Rec Mono Custom" :size 16)
    doom-variable-pitch-font (font-spec :family "Recursive Sans Linear Static" :size 16)
    doom-serif-font (font-spec :family "Recursive Mono casual Static" :size 16)))

(cl-case my/font-mode
  ('triplicate (my/triplicate-fonts))
  ('input (my/input-fonts))
  ('caskaydia (my/caskaydia-fonts))
  ('fira (my/fira-fonts))
  ('recursive (my/recursive-fonts))
  (t (my/cascadia-fonts)))

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tomorrow-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq
  org-directory "~/org/"
  org-journal-dir "~/org/journal/"
  org-roam-directory "~/org/roam/"
  org-agenda-files `(,org-directory))

(setq doom-modeline-modal-icon nil)

;; Projectile configs
(setq projectile-project-search-path '(
                                        ("~/projects" . 2)
                                        ("~/repos" . 3)
                                        ("~/.ghq" . 3)))

;; (load! "hacks/trailing-whitespace.el")

;; Configure org stuff
(after! org
  (require 'org-crypt)
  (org-crypt-use-before-save-magic)
  (setq
    org-clock-sound "~/.dotfiles/sound/fm-bell-synth-02.wav"
    org-time-stamp-formats '("<%Y-%m-%d %a>" . "<%Y-%m-%d %a %H:%M %Z>")
    org-journal-file-format "%Y%m%d.org"
    org-hide-emphasis-markers t
    org-tags-exclude-from-inheritance '("crypt")
    org-crypt-key "0xC58C41E27B00AD04"
    org-roam-capture-templates
    `(("d" "default" plain
        (file ,(concat org-roam-directory "/templates/default.org"))
        :target (file+head "%<%Y%m%dT%H%M%S%z>-${slug}.org"
                  "#+title: ${title}\n#+date: %U\n")
        :unnarrowed t))
    org-roam-dailies-capture-templates
    `(("d" "default" entry
        (file ,(concat org-roam-directory "/templates/dailies/default.org"))
        :target (file+head "%<%Y-%m-%d>.org"
                  "#+title: %<%Y-%m-%d>\n#+date: %U\n")))))

(after! org
  (custom-set-faces!
    '(line-number :inherit fixed-pitch)
    '(line-number-current-line :inherit (hl-line fixed-pitch))
    '(org-default :inherit variable-pitch :height 1.0)
    '(org-document-title :inherit fixed-pitch-serif :height 1.3)
    '(org-level-1 :inherit (outline-1 fixed-pitch-serif) :weight extra-bold :height 1.5)
    '(org-level-2 :inherit (outline-2 fixed-pitch-serif) :weight bold :height 1.25)
    '(org-level-3 :inherit (outline-3 fixed-pitch-serif) :weight bold :height 1.15)
    '(org-level-4 :inherit (outline-4 fixed-pitch-serif) :weight bold :height 1.12)
    '(org-level-5 :inherit (outline-5 fixed-pitch-serif) :weight semi-bold :height 1.09)
    '(org-level-6 :inherit (outline-6 fixed-pitch-serif) :weight semi-bold :height 1.06)
    '(org-level-7 :inherit (outline-7 fixed-pitch-serif) :weight semi-bold :height 1.03)
    '(org-level-8 :inherit (outline-8 fixed-pitch-serif) :weight semi-bold)
    '(org-block :inherit fixed-pitch :weight normal)
    '(org-code :inherit (shadow fixed-pitch))
    '(org-table :inherit (shadow fixed-pitch))
    '(org-verbatim :inherit (shadow fixed-pitch))
    '(org-special-keyword :inherit (font-lock-comment-face fixed-pitch))
    '(org-meta-line :inherit (font-lock-comment-face fixed-pitch))
    '(org-checkbox :inherit (org-todo fixed-pitch))
    '(org-checkbox-statistics-done :inherit (org-done fixed-pitch))
    '(org-checkbox-statistics-todo :inherit (org-todo fixed-pitch))
    '(org-indent :inherit (org-hide fixed-pitch))))

(map!
  :after org-tree-slide
  :map org-tree-slide-mode-map
  :n "C-x s h" #'org-tree-slide-display-header-toggle)

(after! org-tree-slide
  (remove-hook 'org-tree-slide-play-hook #'+org-present-hide-blocks-h)
  (remove-hook 'org-tree-slide-play-hook #'+org-present-hide-blocks-h)
  (advice-remove 'org-tree-slide--display-tree-with-narrow
    #'+org-present--hide-first-heading-maybe-a))

(after! org-journal
  (setq
    org-journal-encrypt-journal t))

(map! :after org-journal
  :map org-journal-mode-map
  :leader
  :desc "Open current journal" "n j c" #'org-journal-open-current-journal-file
  :desc "Search for a string" "n j S" #'org-journal-search)

(load! "hacks/org-roam-alias-display.el")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
