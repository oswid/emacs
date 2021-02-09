(require 'package) 
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package doom-themes
  :ensure t
  :config
;;  (load-theme 'doom-spacegrey t))
;;  (load-theme 'doom-solarized-light))
  (load-theme 'doom-nord-light t))

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))

(use-package all-the-icons
  :ensure t)

;; (use-package rjsx-mode
;;   :ensure t
;;   :mode ("\\.js\\'"
;;          "\\.jsx\\'")
;;   :config
;;   (setq js2-mode-show-parse-errors t
;; 	js2-mode-show-strict-warnings nil
;; 	js2-basic-offset 2
;; 	js-indent-level 2)
;;   (electric-pair-mode 1))


(use-package prettier-js
  :ensure t
  :defer t
  :diminish prettier-js-mode
  :hook (((js2-mode rjsx-mode) . prettier-js-mode)))

(use-package treemacs
  :ensure t
  :bind
  (:map global-map
	([f8] . treemacs)
	("C-<f8>" . treemacs-select-window))
  :config
  (setq treemacs-is-never-other-window t))

(use-package projectile
 :ensure t
 :config
 (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
 (projectile-mode +1))

(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-items '((recents . 3)
			    (projects . 3)
			    (bookmarks . 3)))
    (setq dashboard-set-file-icons t)
    (setq dashboard-startup-banner "c:/emacs/downloads/logo-vim.png")
    )
 :config
 (dashboard-setup-startup-hook)
)


(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x n" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

(use-package swiper
  :ensure t
  :bind (("M-f" . swiper)
	 ("M-r" . ivy-resume)
	 ("M-c" . counsel-M-x))
	 ;; ("M-g" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "M-l") 'counsel-expression-histor)  ))

(use-package counsel
  :ensure t)


(use-package avy
  :ensure t
  :init
      (setq avy-keys '(?a ?o ?u ?u ?i ?d ?h ?t ?n ?s))
      )

(use-package avy-zap
  :ensure t)

(use-package counsel-projectile
  :ensure t
  :bind ("M-C-f" . counsel-projectile-find-file)
  )

(use-package expand-region
  :ensure t
  :bind
  ("C-s" . er/expand-region)
  ;; ("C-w" . er/contract-region)
  )


(use-package emmet-mode
  :ensure t
  :bind ("@" . emmet-expand-line)
  :config
  (add-hook 'web-mode 'emmet-mode)
  (setq emmet-expand-jsx-className? t))



(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   (company-mode +1))

;; (use-package company
;;   :ensure t
;;   :init
;;   (add-hook 'after-init-hook 'global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

;; (use-package web-mode
;;   :ensure t
;;   :mode (("\\.html?\\'" . web-mode)
;;          ("\\.tsx\\'" . web-mode)
;;          ("\\.jsx\\'" . web-mode))
;;   :config
;;   (setq web-mode-markup-indent-offset 2
;;         web-mode-css-indent-offset 2
;;         web-mode-code-indent-offset 2
;;         web-mode-block-padding 2
;;         web-mode-comment-style 2

;;         web-mode-enable-css-colorization t
;;         web-mode-enable-auto-pairing t
;;         web-mode-enable-comment-keywords t
;;         web-mode-enable-current-element-highlight t
;;         )
;;   (add-hook 'web-mode-hook
;;             (lambda ()
;;               (when (string-equal "tsx" (file-name-extension buffer-file-name))
;; 		(setup-tide-mode))))
;;   (flycheck-add-mode 'typescript-tslint 'web-mode))

;; (use-package typescript-mode
;;   :ensure t
;;   :config
;;   (setq typescript-indent-level 2)
;;   (add-hook 'typescript-mode #'subword-mode))

;; (use-package tide
;;   :init
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)))

;; (provide 'typescript)


(use-package evil
  :ensure evil
  :config
      (evil-mode 1)
      (evil-global-set-key 'motion "u" 'evil-next-visual-line)
  )


(use-package winum
  :ensure t
  :config
      (winum-mode))



(use-package magit
  :ensure t)

(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))



(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
  :hook (
	   ;; bind lsp to the development modes I'm interested in.
	   (web-mode . lsp-deferred)
	   (lsp-mode . lsp-enable-which-key-integration))
  :init
  (setq lsp-enable-completion-at-point t)
  (setq lsp-enable-indentation t)
  (setq lsp-enable-on-type-formatting t)
  :commands lsp lsp-deferred)

(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package which-key
  :config
  (which-key-mode))




(use-package tide
  :hook (
       (web-mode . setup-tide-mode)
	 )
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (eldoc-mode +1)
    (company-mode +1)
    (local-set-key [f1] 'tide-documentation-at-point))
  (setq company-tooltip-align-annotations t)
  (setq tide-sort-completions-by-kind t)
)

(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
	   ("\\.jsx\\'" . web-mode)
	   ("\\.ts\\'" . web-mode)
	   ("\\.tsx\\'" . web-mode)
	   ("\\.html\\'" . web-mode)
	   ("\\.vue\\'" . web-mode)
	   ("\\.json\\'" . web-mode))
  :commands web-mode
  :config
  (setq company-tooltip-align-annotations t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-part-face t)
  (setq web-mode-content-types-alist
	  '(("jsx" . "\\.js[x]?\\'")))
  )



;; (defun efs/lsp-mode-setup ()
;;   (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
;;   (lsp-headerline-breadcrumb-mode))

;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :hook (lsp-mode . efs/lsp-mode-setup)
;;   :init
;;   (setq lsp-keymap-prefix "c-c l")  ;; or 'c-l', 's-l'
;;   :config
;;   (lsp-enable-which-key-integration t))


;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :custom
;;   (lsp-ui-doc-position 'bottom))


;; (use-package lsp-treemacs
;;   :after lsp)


;; ;; (use-package lsp-ivy)

;; (use-package typescript-mode
;;   :mode "\\.ts\\'"
;;   :hook (typescript-mode . lsp-deferred)
;;   :config
;;   (setq typescript-indent-level 2))



;; (use-package company
;;   :after lsp-mode
;;   :hook (lsp-mode . company-mode)
;;   :bind (:map company-active-map
;;          ("<tab>" . company-complete-selection))
;;         (:map lsp-mode-map
;;          ("<tab>" . company-indent-or-complete-common))
;;   :custom
;;   (company-minimum-prefix-length 1)
;;   (company-idle-delay 0.0))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))


