;; Init.el

(defvar bootstrap-version)
 (let ((bootstrap-file
 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
 (bootstrap-version 5))
 (unless (file-exists-p bootstrap-file)
 (with-current-buffer
 (url-retrieve-synchronously
 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
 'silent 'inhibit-cookies)
 (goto-char (point-max))
 (eval-print-last-sexp)))
 (load bootstrap-file nil 'nomessage))

;; (require 'package)
;; (setq package-archives '(("melpa" . "https://melpa.org/packages/")
;; ;       ("org" . "https://orgmode.org/elpa/")
;; ("elpa" . "https://elpa.gnu.org/packages/")))

;; (require 'use-package)
;; (setq use-package-always-ensure t)                     

;; (use-package org)
;; ;
					; (org-babel-load-file
;;    (expand-file-name "init_bkk.org"
;;                      "~/.emacs.d"))
(load-file "~/.emacs.d/init_bkk.el")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-default-directory-list
   '("/usr/local/share/info/" "/usr/share/info/" "/home/bkk/config/guix/current/share/guix"))
 '(bongo-enabled-backends '(mpv))
 '(custom-safe-themes
   '("1aa4243143f6c9f2a51ff173221f4fd23a1719f4194df6cef8878e75d349613d" "4b0e826f58b39e2ce2829fab8ca999bcdc076dec35187bf4e9a4b938cb5771dc" "028c226411a386abc7f7a0fba1a2ebfae5fe69e2a816f54898df41a6a3412bb5" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "4b6b6b0a44a40f3586f0f641c25340718c7c626cbf163a78b5a399fbe0226659" "8d7b028e7b7843ae00498f68fad28f3c6258eda0650fe7e17bfb017d51d0e2a2" "c4063322b5011829f7fdd7509979b5823e8eea2abf1fe5572ec4b7af1dd78519" "cbdf8c2e1b2b5c15b34ddb5063f1b21514c7169ff20e081d39cf57ffee89bc1e" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "97db542a8a1731ef44b60bc97406c1eb7ed4528b0d7296997cbb53969df852d6" "234dbb732ef054b109a9e5ee5b499632c63cc24f7c2383a849815dacc1727cb6" "7a7b1d475b42c1a0b61f3b1d1225dd249ffa1abb1b7f726aec59ac7ca3bf4dae" "266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" default))
 '(denote-directory "/home/bkk/git/orgfiles/denote")
 '(denote-prompts '(title keywords subdirectory))
 '(mail-envelope-from 'header)
 '(message-sendmail-envelope-from 'header)
 '(org-agenda-files '("~/shared/dox/vit/20220817T105609--meta__meta.org"))
 '(package-selected-packages
   '(general doom-themes helpful counsel ivy-rich which-key rainbow-delimiters use-package no-littering ivy doom-modeline command-log-mode auto-package-update))
 '(safe-local-variable-values
   '((eval let
	   ((root-dir-unexpanded
	     (locate-dominating-file default-directory ".dir-locals.el")))
	   (when root-dir-unexpanded
	     (let*
		 ((root-dir
		   (expand-file-name root-dir-unexpanded))
		  (root-dir*
		   (directory-file-name root-dir)))
	       (unless
		   (boundp 'geiser-guile-load-path)
		 (defvar geiser-guile-load-path 'nil))
	       (make-local-variable 'geiser-guile-load-path)
	       (require 'cl-lib)
	       (cl-pushnew root-dir* geiser-guile-load-path :test #'string-equal))))
     (eval with-eval-after-load 'yasnippet
	   (let
	       ((guix-yasnippets
		 (expand-file-name "etc/snippets/yas"
				   (locate-dominating-file default-directory ".dir-locals.el"))))
	     (unless
		 (member guix-yasnippets yas-snippet-dirs)
	       (add-to-list 'yas-snippet-dirs guix-yasnippets)
	       (yas-reload-all))))
     (eval setq-local guix-directory
	   (locate-dominating-file default-directory ".dir-locals.el"))
     (eval add-to-list 'completion-ignored-extensions ".go")))
 '(warning-suppress-types '((comp)))
 '(which-key-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
