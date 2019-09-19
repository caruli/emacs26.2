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
