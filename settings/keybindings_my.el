(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq default-directory "e:/")


;; find file create input directory 
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir t)))))

(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-set-key (kbd "H-i") 'save-buffer)

;; example of a function that just insert a tab char
;; (defun my-insert-tab-char ()
;;   "insert a tab char. (ASCII 9, \t)"
;;   (interactive)
;;   (insert "\t")
  ;; )

;; (global-set-key (kbd "<tab>") 'my-insert-tab-char)

;; move keybindings
(global-set-key (kbd "C-o") 'forward-char)
(global-set-key (kbd "C-a") 'backward-char)
(global-set-key (kbd "C-u") 'previous-line)
(global-set-key (kbd "C-e") 'next-line)

(global-set-key (kbd "C-r") 'move-beginning-of-line)
(global-set-key (kbd "C-l") 'end-of-line)
;;(global-set-key (kbd "C-m") 'next-word)
;; (global-set-key (kbd "C-b") 'previous-word)


(setq default-directory "c:/")

 ;; align text
;;(global-set-key (kbd "C-y") 'fill-paragraph)

 ;;copy
(global-set-key (kbd "C-y") 'kill-ring-save)
 ;;paste
(global-set-key (kbd "C-p") 'yank)

(global-set-key (kbd "C-k") 'undo)

;; copy line
;;(global-set-key "\C-h" "\C-a\C- \C-n\M-w\C-y")

;; ========== prefix keymap ===============
;; == define a prefix keymap for YANK keys
(progn
  (define-prefix-command 'my-yank-map)
  (define-key my-yank-map (kbd "C-e") 'kill-ring-save)
  (define-key my-yank-map (kbd "C-y") 'copy-line)
  ;; (define-key my-yank-map (kbd "C-d") 'kill-whole-line)
  ;; (define-key my-yank-map (kbd "C-t") 'avy-zap-to-char-dwim)
  )
(global-set-key (kbd "C-y") my-yank-map)

    (defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;; ========== prefix keymap ===============
;; == define a prefix keymap for PASTE keys
(progn
  (define-prefix-command 'my-paste-map)
  (define-key my-paste-map (kbd "C-p") 'yank)
  (define-key my-paste-map (kbd "C-d") 'duplicate-line)
  (define-key my-paste-map (kbd "C-o") 'insert-line-below)
  (define-key my-paste-map (kbd "C-a") 'insert-line-above)
  (define-key my-paste-map (kbd "C-c") 'avy-mark-to-char)
  )
(global-set-key (kbd "C-p") my-paste-map)


(defun avy-mark-to-char (pt)
  "Copy to the mark"
  (interactive)
  (set-mark (point))
  (goto-char pt))

(defun insert-line-below ()
  "Insert an empty line below the current line."
  (interactive)
    (end-of-line)
    (open-line 1)
    (next-line 1))

(defun insert-line-above ()
  "Insert an empty line above the current line."
  (interactive)
    (end-of-line 0)
    (open-line  1)
    (next-line 1))


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
)

;; == define a prefix keymap for DELETE keys
(progn
  (define-prefix-command 'my-del-map)
  (define-key my-del-map (kbd "C-w") 'kill-word)
  (define-key my-del-map (kbd "C-e") 'kill-line)
  (define-key my-del-map (kbd "C-d") 'kill-whole-line)
  (define-key my-del-map (kbd "C-t") 'avy-zap-to-char-dwim)
  )
(global-set-key (kbd "C-d") my-del-map)


;; ==  define a prefix keymap for WINDOW keys
(progn
  (define-prefix-command 'my-win-map)
  (define-key my-win-map (kbd "C-v") 'split-window-vertically)
  (define-key my-win-map (kbd "C-n") 'other-window)
  (define-key my-win-map (kbd "C-h") 'split-window-horizontally)
  (define-key my-win-map (kbd "C-c") 'delete-window) 
  )
(global-set-key (kbd "C-w") my-win-map)


;; ==  define a prefix keymap for LINE-CROWLER keys
(progn
  (define-prefix-command 'my-g-key)
  (define-key my-g-key (kbd "C-t") 'switch-to-buffer)
  (define-key my-g-key (kbd "C-g") 'beginning-of-buffer)
  (define-key my-g-key (kbd "C-c") 'end-of-buffer)
  (define-key my-g-key (kbd "C-l") 'goto-line)
  (define-key my-g-key (kbd "C-s") 'isearch-forward)
  (define-key my-g-key (kbd "C-r") 'query-replace)
  ;; (define-key my-g-key (kbd "C-r") 'anzu-query-replace)
  )
(global-set-key (kbd "C-g") my-g-key)


;; ==  define a prefix keymap for BUF-KILL-REFRESH keys
(progn
  (define-prefix-command 'my-kill-key)
  (define-key my-kill-key (kbd "C-z") 'kill-buffer)
  (define-key my-kill-key (kbd "C-c") 'save-buffers-kill-terminal)
  (define-key my-kill-key (kbd "C-s") 'list-buffers)
  (define-key my-kill-key (kbd "C-r") 'reload-dotemacs-file)

  )
(global-set-key (kbd "C-z") my-kill-key)


(defun reload-dotemacs-file ()
;; ==  reload your .emacs file without restarting Emacs
   (interactive)
   (load-file "~/.emacs") 
   )

;; ==  define a prefix keymap for FIND keys
(progn
  (define-prefix-command 'my-find-key)
  (define-key my-find-key (kbd "C-f") 'counsel-find-file)
  (define-key my-find-key (kbd "C-n") 'find-file)
  (define-key my-find-key (kbd "C-t") 'list-buffers)
  (define-key my-find-key (kbd "C-p") 'counsel-projectile-rg)
  (define-key my-find-key (kbd "C-b") 'counsel-projectile-switch-to-buffer)
  )
(global-set-key (kbd "C-f") my-find-key)

;; ==  define a prefix keymap for MARKS keys
(progn
  (define-prefix-command 'my-marks-key)
  (define-key my-marks-key (kbd "C-c") 'set-mark-command)
  (define-key my-marks-key (kbd "C-g") 'bookmark-set)
  (define-key my-marks-key (kbd "C-r") 'bookmark-jump)
  (define-key my-marks-key (kbd "C-l") 'list-bookmarks)

  )
(global-set-key (kbd "C-c") my-marks-key)


;; =========== my functions ==============

;; ========== buffers ==============

;; ==  Switch to the next emacs buffer
(defun xah-next-emacs-buffer ()
  (interactive)
  (next-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (next-buffer))))

;; ==  Switch to the previous emacs buffer
(defun xah-previous-emacs-buffer ()
  (interactive)
  (previous-buffer)
  (let ((i 0))
    (while (and (not (string-equal "*" (substring (buffer-name) 0 1))) (< i 20))
      (setq i (1+ i)) (previous-buffer))))
	

(global-set-key (kbd "<C-tab>") 'xah-previous-emacs-buffer)
;; (global-set-key (kbd "<C-S-tab>") 'xah-next-emacs-buffer)




 (defun comment-or-uncomment-region-or-line ()
     "Comments or uncomments the region or the current line if there's no active region."
     (interactive)
     (let (beg end)
         (if (region-active-p)
             (setq beg (region-beginning) end (region-end))
             (setq beg (line-beginning-position) end (line-end-position)))
         (comment-or-uncomment-region beg end)))

 (global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)


;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))



(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-a") nil)
  (define-key org-mode-map (kbd "C-o") nil)
  (define-key org-mode-map (kbd "C-e") nil)
  (define-key org-mode-map (kbd "C-u") nil)
  (define-key org-mode-map (kbd "C-i") nil)
  (define-key org-mode-map (kbd "C-p") nil)
  (define-key org-mode-map (kbd "C-y") nil)
  (define-key org-mode-map (kbd "C-c") nil)
  (define-key org-mode-map (kbd "C-k") nil))



(with-eval-after-load 'rjsx-mode
  (define-key rjsx-mode-map "<" nil)
  (define-key rjsx-mode-map (kbd "C-d") nil)
  (define-key rjsx-mode-map ">" nil))

;; (global-set-key (kbd "C-0") nil)
(global-set-key (kbd "C-1") nil)
(global-set-key (kbd "C-2") nil)
(global-set-key (kbd "C-3") nil)
(global-set-key (kbd "C-4") nil)
(global-set-key (kbd "C-5") nil)
(global-set-key (kbd "C-6") nil)
(global-set-key (kbd "C-7") nil)
(global-set-key (kbd "C-8") nil)
(global-set-key (kbd "C-9") nil)

(global-set-key (kbd "C-1") 'winum-select-window-1)
(global-set-key (kbd "C-2") 'winum-select-window-2)
(global-set-key (kbd "C-3") 'winum-select-window-3)
(global-set-key (kbd "C-4") 'winum-select-window-4)
(global-set-key (kbd "C-5") 'winum-select-window-5)
(global-set-key (kbd "C-6") 'winum-select-window-6)


;(define-key winum-keymap (kbd "C-1") #'winum-select-window-1)
;(define-key winum-keymap (kbd "C-2") #'winum-select-window-2)
;; (define-key winum-keymap (kbd "C-3") #'winum-select-window-3)
;; (define-key winum-keymap (kbd "C-4") #'winum-select-window-4)
;; (define-key winum-keymap (kbd "C-5") #'winum-select-window-5)
;; (define-key winum-keymap (kbd "C-6") #'winum-select-window-6)
