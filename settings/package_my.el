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

(use-package rjsx-mode
  :ensure t
  :mode ("\\.js\\'"
         "\\.jsx\\'")
  :config
  (setq js2-mode-show-parse-errors t
	js2-mode-show-strict-warnings nil
	js2-basic-offset 2
	js-indent-level 2)
  (electric-pair-mode 1))

;; (use-package tide
;;   :ensure t
;;   :after (typescript-mode company flycheck)
;;   :hook ((typescript-mode . tide-setup)
;;          (typescript-mode . tide-hl-identifier-mode)
;;          (before-save . tide-format-before-save)))

;; (use-package web-mode
;;   :ensure t)

;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               (setup-tide-mode))))
;; ;; enable typescript-tslint checker
;; (add-hook 'typescript-tslint 'web-mode)

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
  :bind ("M-C-l" . avy-goto-char))

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
  :bind ("TAB" . emmet-expand-line)
  :config
  (add-hook 'rjsx-mode 'emmet-mode)
  (setq emmet-expand-jsx-className? t))


;; ======== typescript

;;; typescript.el --- typescript support
;;; Commentary:
;;; Code:

(use-package flycheck
  :ensure t
  :config
  (add-hook 'typescript-mode-hook 'flycheck-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(use-package company
  :ensure t
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (global-company-mode))

(use-package company-quickhelp
  :ensure t
  :init
  (company-quickhelp-mode 1)
  (use-package pos-tip
    :ensure t))

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        )
  (add-hook 'web-mode-hook
            (lambda ()
              (when (string-equal "tsx" (file-name-extension buffer-file-name))
		(setup-tide-mode))))
  (flycheck-add-mode 'typescript-tslint 'web-mode))

(use-package typescript-mode
  :ensure t
  :config
  (setq typescript-indent-level 2)
  (add-hook 'typescript-mode #'subword-mode))

(use-package tide
  :init
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(provide 'typescript)
;;; typescript.el ends here


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
