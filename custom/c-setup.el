;; custom compilation
(setq compilation-read-command nil)
(global-set-key "\C-x\C-m" 'compile)

(add-hook 'c-mode-hook
	  (lambda ()
	    (unless (file-exists-p "Makefile")
	      (set (make-local-variable 'compile-command)
		   ;; emulate make's .c.o implicit pattern rule, but with
		   ;; different defaults for the CC, CPPFLAGS, and CFLAGS
		   ;; variables:
		   ;; $(CC) -c -o $@ $(CPPFLAGS) $(CFLAGS) $<
		   (let ((file (file-name-nondirectory buffer-file-name)))
		       (format "%s -o  %s %s %s %s"
			       (or (getenv "CC") "gcc")
			     (file-name-sans-extension file)
			     (or (getenv "CPPFLAGS") "-DDEBUG=9")
			     (or (getenv "CFLAGS") " -Wall -g")
				   file))))))


(defun notify-compilation-result(buffer msg)
"Notify that the compilation is finished,
close the *compilation* buffer if the compilation is successful,
and set the focus back to Emacs frame"
    (if (string-match "^finished" msg)
	(progn
	  (delete-windows-on buffer))
	  ;;(tooltip-show "\n Compilation Successful :-) \n "))
      (tooltip-show "\n Compilation Failed :-( \n "))
     (setq current-frame (car (car (cdr (current-frame-configuration)))))
      (select-frame-set-input-focus current-frame)
     )

(add-to-list 'compilation-finish-functions
		  'notify-compilation-result)

(provide 'c-setup)




















