(blink-cursor-mode nil)
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Set default font
(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 110
                    :weight 'normal
                    :width 'normal)

(tool-bar-mode -1)

(menu-bar-mode -1)

(scroll-bar-mode -1)

(global-hl-line-mode +1)

(delete-selection-mode 1)

(setq backup-directory-alist '(("." . "~/.saves")))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(show-paren-mode 1)

 
