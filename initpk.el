(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
("gnu"   . "http://elpa.gnu.org/packages/")
("melpa" . "http://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
(package-refresh-contents)
(package-install 'use-package))
(add-to-list 'load-path "~/.emacs.d/custom" )

(require 'setup-general)
(require 'external-packages)
;; (require 'setup-c)

;; (use-package auto-complete
;;   :ensure t
;;   :config (global-auto-complete-mode 1)
;;  ;;(ac-config-default)
;;  ;;(add-to-list 'ac-modes 'org-mode))
;;  (define-key ac-complete-mode-map "\C-n" 'ac-next)
;;  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; )



;; (use-package yasnippet
;;   :ensure t
;;   :init
;;   (yas-global-mode 1))




;; (use-package auto-complete
;;   :ensure t
;;   :init
;;   (ac-config-default)
;;   (global-auto-complete-mode t)
;;   (define-key ac-complete-mode-map "\C-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; )



;; (use-package auto-complete-c-headers
;;     :ensure t
;;     :config
;;  (defun my:ac-c-header-init ()
;; ; now let's call this function from c/c++ hooks
;;     (add-to-list 'ac-sources 'ac-source-c-headers)
;;     (add-to-list 'achead:include-directories '"/usr/include/arm-linux-gnueabihf")
;;     (add-hook 'c-mode-hook 'my:ac-c-header-init)
;; ))






			
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
	        ))

(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)


;; (defun my:ac-c-header-init ()
;;   (require 'auto-complete-c-headers)
;;   (add-to-list 'ac-sources 'ac-source-c-headers)
;;   (add-to-list 'achead:include-directories '"/usr/include")
;;   )
;; 					; now let's call this function from c/c++ hooks
;; (add-hook 'c++-mode-hook 'my:ac-c-header-init)
;; (add-hook 'c-mode-hook 'my:ac-c-header-init)


					; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)







