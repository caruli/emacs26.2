;;  mode line showing message after delay
(defun my-show-in-mode-line (text &optional buffer delay)
    "Display TEXT in BUFFER's mode line.
The text is shown for DELAY seconds (default 2), or until a user event.
So call this last in a sequence of user-visible actions."
    (message nil) ; Remove any current msg
    (with-current-buffer (or buffer  (current-buffer))
      (make-local-variable 'mode-line-format) ; Needed for Emacs 21+.
      (let ((mode-line-format  text))
	(force-mode-line-update) (sit-for (or delay  2)))
	 (force-mode-line-update)))

;; reload current buffer in mode line
(defun reload-buffer ()
  "Relload current buffer."
  (interactive)
  (eval-buffer)
  (my-show-in-mode-line "reloaded..." ))
(global-set-key (kbd "C-z") 'reload-buffer)


;; Minimal UI
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
;; (scroll-all-mode -1)
;;(scroll-bar-mode -1)
(blink-cursor-mode 0)
; Set cursor color to white "#ffffff"
(add-hook 'after-init-hook
 (lambda ()
 (set-cursor-color "gray")))

(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)
;; find the init.el
(defun find-init ()
    "Find init.el."
    (interactive)
    ;;(split-window-horizontally)
    ;; (find-file-other-window user-init-file))
    ;;(add-hook 'after-change-major-mode-hook
    ;; '(lambda ()
    ;;(linum-mode (if (or (equal major-mode 'text-mode) (equal major-mode 'term-mode) (equal major-mode 'help-mode)) 0 1))))
    (find-file user-init-file))
(global-set-key (kbd "C-c e") 'find-init)


;; windows moving
(global-set-key (kbd "M-j") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-i") 'windmove-up)
(global-set-key (kbd "M-m") 'windmove-down)


(defun xah-comment-dwim ()
    "Like `comment-dwim', but toggle comment if cursor is not at end of line.
URL `http://ergoemacs.org/emacs/emacs_toggle_comment_by_line.html'
Version 2016-10-25"
    (interactive)
    (if (region-active-p)
	(comment-dwim nil)
      (let (($lbp (line-beginning-position))
	    ($lep (line-end-position)))
	(if (eq $lbp $lep)
	    (progn
	      (comment-dwim nil))
	  (if (eq (point) $lep)
	      (progn
		(comment-dwim nil))
	    (progn
	      (comment-or-uncomment-region $lbp $lep)
	      (forward-line )))))))

(global-set-key (kbd "M-;") 'xah-comment-dwim)



;; To make ediff to be horizontally split use:
(setq ediff-split-window-function 'split-window-horizontally)

;; This is what you probably want if you are using a tiling window
;; manager under X, such as ratpoison.
(setq ediff-window-setup-function 'ediff-setup-windows-plain)




;;(setq initial-buffer-choice user-init-file)
;; set the C-h key to function as delete-backword-char (keyboard key backspace )
(global-set-key "\C-h" 'delete-backward-char)
;; makes C-n insert newline if the point (cursor) is at the end of the buffer
(setq next-line-add-newlines t)

;; mode-line customization
(setq line-number-mode t)
(setq column-number-mode t)
(setq column-number-indicator-zero-based nil)
;; help
(defun myhelp ()
  "Open help in other window"
  (interactive)
  (help)
  (other-window 1))
  (global-set-key "\C-xh" 'myhelp)
;; Time format
;;(defvar display-time-24hr-format t)
;;(defvar display-time-format "%H:%M - %d %B %Y")
;;(display-time-mode 1)

;; Reverse colors for the border to have nicer line
(set-face-inverse-video-p 'vertical-border nil)
(set-face-background 'vertical-border (face-background 'default))

;; Set symbol for the vertical border
(window-divider-mode -1)

(set-display-table-slot standard-display-table
			'vertical-border
			(make-glyph-code ?┃))

(set-face-background 'vertical-border "gray")
(set-face-foreground 'vertical-border (face-background 'vertical-border))



;; windows moving
(global-set-key (kbd "M-j") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
(global-set-key (kbd "M-i") 'windmove-up)
(global-set-key (kbd "M-k") 'windmove-down)
;; windows resizing
(global-set-key (kbd "C-c j") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c l") 'shrink-window-horizontally)
(global-set-key (kbd "C-c i") 'enlarge-window)
(global-set-key (kbd "C-c k") 'shrink-window)

;; window splitting function
(defun split-and-follow-vertically ()
  "Split."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)
(defun split-and-follow-horizontally ()
  "Split horizontally."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
;; find cursor easily
;;(when window-system (global-hl-line-mode t))
;;(set-face-background 'hl-line "gray")

(global-prettify-symbols-mode t)
;; faster moving cursor
(setq scroll-conservatively 300)
;; no backup files
(defvar make-backup-file nil)
(setq auto-save-default nil)
;; custom function window-split-toggle
(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
		    #'split-window-vertically
		  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
	(other-window 1)
		(switch-to-buffer (other-buffer))))))



;; frames
(set-frame-parameter nil 'fullscreen 'fullboth)
;; nil is not "disable", it is the current window, the 0's are the left and right fringe
;;(set-window-fringes nil 0 1)
;; You can completely eliminate the fringe fringe-mode (not just reduce its size) by using
;;(fringe-mode 0)
(set-window-fringes nil 7 0)


;; (set-face-background 'vertical-border "gray")
;; (set-face-foreground 'vertical-border (face-background 'vertical-border))(set-face-background 'vertical-border "gray")
;; (set-face-foreground 'vertical-border (face-background 'vertical-border))

(set-face-attribute 'vertical-border nil  :foreground "#282a2e")


;; mode line
;;(setq-default mode-line-format -1)
(provide 'setup-general)
