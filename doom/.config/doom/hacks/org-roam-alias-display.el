;;; $DOOMDIR/hacks/org-roam-alias-display.el -*- lexical-binding: t; -*-

(after! org-roam
  (cl-defmethod org-roam-node-orig-pointer ((node org-roam-node))
    (let* ((title (org-roam-node-title node))
           (props (org-roam-node-properties node))
           (aliases0 (cdr (assoc "ROAM_ALIASES" props)))
           (aliases (if aliases0 (split-string-and-unquote aliases0) nil)))
      (if (and aliases (listp aliases) (member title aliases))
        (let ((item (cdr (assoc "ITEM" props))))
          (format "→ %s" (if item item (org-roam-node-file-title node))))
        "")))

  (setq org-roam-node-display-template
    (format "${doom-hierarchy:*} ${orig-pointer:30} %s %s"
      (propertize "${doom-type:12}" 'face 'font-lock-keyword-face)
      (propertize "${doom-tags:42}" 'face 'org-tag))))
