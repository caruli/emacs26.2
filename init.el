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
(require 'c-setup)

;; working
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3)
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "M-n") nil)
    (define-key company-active-map (kbd "M-p") nil)
    (define-key company-active-map (kbd "C-n") #'company-select-next)
    (define-key company-active-map (kbd "C-p") #'company-select-previous))
    (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend company-preview-frontend company-echo-metadata-frontend)    )
    )

;; Turning off the warnings is as easy as adding:
(setq ad-redefinition-action 'accept)


;; ansi-term
(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  "ansi-term."
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
;; (other-window 1)

(global-set-key (kbd "C-c s") 'ansi-term)
;; (defadvice ansi-term (after advice-term-line-mode activate)
;;   (term-line-mode))
(defadvice ansi-term (after advice-term-char-mode activate)
  (term-char-mode))


