;; -*- lexical-binding: t -*-
;; init.org

(setq inhibit-startup-message t)

(desktop-save-mode 1)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips

(menu-bar-mode -1)         ; Disable the menu bar
(set-fringe-mode 10)        ; Give some breathing room
;(menu-bar-mode t)
;(tool-bar-mode t)          ; Disable the toolbar
;; Set up the visible bell
(setq visible-bell t)

;(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c e") 'evil-mode)
;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
       ("org" . "https://orgmode.org/elpa/")
("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
(package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(column-number-mode)
(global-display-line-numbers-mode  
(setq  display-line-numbers-type 'relative))
;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
prog-mode-hook
conf-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook
		vterm-mode-hook
		eshell-mode-hook
	      info-mode-hook))
(add-hook mode (lambda () (display-line-numbers-mode 0))))


(setq debug-on-error t) 

(use-package command-log-mode)

(setq org-src-fontify-natively t
org-src-tab-acts-natively t
org-confirm-babel-evaluate nil
org-edit-src-content-indentation 0)
(use-package ivy
:diminish
:bind (("C-s" . swiper)
:map ivy-minibuffer-map
;("TAB" . ivy-alt-done)
("C-l" . ivy-alt-done)
:map ivy-minibuffer-map
("C-j" . ivy-next-line)
("C-k" . ivy-previous-line)
:map ivy-switch-buffer-map
("C-k" . ivy-previous-line)
("C-l" . ivy-done)
("C-d" . ivy-switch-buffer-kill)
:map ivy-reverse-i-search-map
("C-k" . ivy-previous-line)
("C-d" . ivy-reverse-i-search-kill))
:config
(ivy-mode 1))
;(global-set-key (kbd "C-M-w") 'counsel-ibuffer)
(setq evil-undo-system 'undo-tree)
(use-package all-the-icons)
;;(use-package doom-modeline
;;:ensure t
;;:init (doom-modeline-mode 1)
;; :custom ((doom-modeline-height 15))
;; :config (setq doom-modeline-icon t))
;; ;(use-package doom-themes)
;:init(load-theme 'doom-ir-black t)

(load-file "~/.emacs.d/bkk-modus-vivendi.el") 

(use-package rainbow-delimiters
:hook (prog-mode . rainbow-delimiters-mode))
(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(custom-safe-themes
'("266ecb1511fa3513ed7992e6cd461756a895dcc5fef2d378f165fed1c894a78c" default))
'(package-selected-packages
'(general doom-themes helpful counsel ivy-rich which-key rainbow-delimiters use-package no-littering ivy doom-modeline command-log-mode auto-package-update))
'(which-key-mode t))
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
(use-package which-key
:init (which-key-mode)
:diminish 'which-key-mode
:config
(setq which-key-idle-delay 0))

(use-package ivy-rich
:init
(ivy-rich-mode 1))

(use-package counsel
:bind (("M-x" . counsel-M-x)
("C-M-b" . counsel-ibuffer)
("C-x C-f" . counsel-find-file)
:map minibuffer-local-map
("C-r" . 'counsel-minibueffer-history)))

 (use-package helpful
   :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


(use-package general
:config
(general-create-definer rune/leader-keys
:keymaps '(normal insert visual emacs)
:prefix "SPC"
:global-prefix "C-SPC")

(general-create-definer bkk/ctrl-c-keys
:prefix "C-c")

(rune/leader-keys
"t" '(:ignore t :which-key "toggles")))

(use-package evil
:init
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-fine-undo t)
;(setq evil-want-C-u-scroll t)
;(setq evil-want-C-i-jump nil)

:config
(evil-mode 1) 
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state) 
(define-key evil-insert-state-map (kbd "C-m") 'delete-char)
(define-key evil-insert-state-map (kbd "RET") 'newline)
;(define-key evil-normal-state-map (kbd "u")  'undo-only)
(define-key evil-normal-state-map (kbd "C-r") 'evil-redo)
;; Use visual line motions even outside of visual-line-mode buffers
(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection 
:after evil
:config
(evil-collection-init))


(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
"scale text"
("j" text-scale-increase "in")
("k" text-scale-decrease "out")
("f" nil "finished" :exit t))

(rune/leader-keys
"ts" '(hydra-text-scale/body :which-key "scale text"))

(use-package projectile
:diminish projectile-mode
:config (projectile-mode)
:custom ((projectile-completion-system 'ivy))
:bind-keymap
("C-c p" . projectile-command-map)
:init
;; NOTE: Set this to the folder where you keep your Git repos!
(when (file-directory-p "~/git/")
(setq projectile-project-search-path '("~/git/")))
(setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
:config (counsel-projectile-mode))

(use-package forge)



;; (defun bkk/org-mode-setup ()
;; (org-indent-mode)
;; (message (emacs-init-time))
;; (variable-pitch-mode 1)
;; (visual-line-mode 1))

;; ;; Org Mode Configuration ------------------------------------------------------

;; (defun bkk/org-font-setup ()
;; ;; Replace list hyphen with dot
;; (font-lock-add-keywords 'org-mode
;; '(("^ *\\([-]\\) "
;; (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; ;; Set faces for heading levels
;; (dolist (face '((org-level-1 . 1.2)
;; (org-level-2 . 1.1)
;; (org-level-3 . 1.05)
;; (org-level-4 . 1.0)
;; (org-level-5 . 1.1)
;; (org-level-6 . 1.1)
;; (org-level-7 . 1.1)
;; (org-level-8 . 1.1)))
;; (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

;; ;; Ensure that anything that should be fixed-pitch in Org files appears that way
;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
;; (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

;; (use-package org
;; :hook (org-mode . bkk/org-mode-setup)
;; :pin manual
;; :config
;; (setq org-ellipsis " ▾")
;; (bkk/org-font-setup))
;; ;:demand t
;; ; :load-path "~/.emacs.d/elpa/org-mode/lisp")




;; ;; (org-babel-load-file
;; ;;  (expand-file-name "init_bkk.org"
;; ;;                    user-emacs-directory))


;; (use-package org-bullets
;; :after org
;; :hook (org-mode . org-bullets-mode)
;; :custom
;; (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; ;; (defun bkk/org-mode-visual-fill ()
;; ;; (setq visual-fill-column-width 100
;; ;;  visual-fill-column-center-text t)
;; ;;   (visual-fill-column-mode 1))

;; ;;    (use-package visual-fill-column
;; ;;     :hook (org-mode . bkk/org-mode-visual-fill))


;; (use-package org-roam
;; :ensure t
;; :init
;; (setq org-roam-v2-ack t)
;; :custom
;; (org-roam-directory "~/git/orgfiles/roam")
;; :bind (("C-c n l" . org-roam-buffer-toggle)
;; ("C-c n f" . org-roam-node-find)
;; ("C-c n i" . org-roam-node-insert))
;; :config
;; (org-roam-setup))


;; (use-package org-roam-ui
;;   :straight
;;     (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
;;     :after org-roam
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;; ;;  :hook (after-init . org-roam-ui-mode)
;;     :config
;;     (setq org-roam-ui-sync-theme t
;;           org-roam-ui-follow t
;;           org-roam-ui-update-on-save t
;;           org-roam-ui-open-on-start nil))

;; (use-package websocket
;; :after org-roam
;; :straight (:host github :repo "ahyatt/emacs-websocket" :branch "main")
;; )

;; (use-package simple-httpd
;; :after org-roam
;; )

;; (use-package org-roam-ui
;; :straight
;; (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
;; :after org-roam
;; ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;; ;;         a hookable mode anymore, you're advised to pick something yourself
;; ;;         if you don't care about startup time, use
;; ;; :hook (after-init . org-roam-ui-mode)
;; :config
;; (setq org-roam-ui-sync-theme t
;; org-roam-ui-follow t
;; org-roam-ui-update-on-save t
;; org-roam-ui-open-on-start nil))

(use-package elfeed
:ensure t
:config
(setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
elfeed-show-entry-switch 'display-buffer)
;(elfeed-org)
:bind
("C-x w" . elfeed )) 



;; (use-package elfeed-org
;; :ensure t
;; :config
;; (setq elfeed-show-entry-switch 'display-buffer)
;; (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))
;; (use-package elfeed-goodies
;; :ensure t
;; :config
;; (elfeed-goodies/setup))

;; (setq elfeed-feeds
;;   '("http://nullprogram.com/feed/"
;;    "https://planet.emacslife.com/atom.xml"))



;; (set-frame-parameter (selected-frame) 'alpha '(75 . 75))
;; (add-to-list 'default-frame-alist '(alpha . (75 . 75)))


(defun toggle-transparency ()
(interactive)
(let ((alpha (frame-parameter nil 'alpha)))
(set-frame-parameter
nil 'alpha
(if (eql (cond ((numberp alpha) alpha)
((numberp (cdr alpha)) (cdr alpha))
;; Also handle undocumented (<active> <inactive>) form.
((numberp (cadr alpha)) (cadr alpha)))
100)
'(65 . 65) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)




(add-hook 'emacs-startup-hook(lambda ()(message "Emacs ready in %s with %d garbage collections."(format "%.2f seconds"(float-time(time-subtract after-init-time before-init-time)))gcs-done)))



;; (use-package elfeed-dashboard
;;   :ensure t
;;   :config
;; ;;  (setq elfeed-dashboard-file "~/.emacs.d/elfeed-dashboard.org")
;;   ;; update feed counts on elfeed-quit
;;   (advice-add 'elfeed-search-quit-window :after #'elfeed-dashboard-update-links))





(use-package go-mode)
(use-package haskell-mode)


(use-package slime) 
(use-package paredit)



;; Configure SBCL as the Lisp program for SLIME.
(add-to-list 'exec-path "/usr/local/bin")
(setq inferior-lisp-program "sbcl")


;; Enable Paredit.
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode) 
(add-hook 'eval-expression-minibuffer-setup-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'slime-repl-mode-hook 'enable-paredit-mode)
(defun override-slime-del-key ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-del-key)

;; Enable Rainbow Delimiters.
(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'ielm-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-interaction-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'slime-repl-mode-hook 'rainbow-delimiters-mode)


(use-package geiser-mit)





;; (use-package run-assoc)
;; (setq associated-program-alist
;; ;;      '(("zathura --fork " "\\.pdf$")

;;       '(("zathura" "\\.pdf$")
;;         ;; etc.
;; 	("mpv" "\\.mp4$")))


;; (setq dired-guess-shell-alist-user
;;       (list
;;        (list "\\.pdf$" "zathura")));;
(use-package crux

:bind
(("C-c o" . crux-open-with)))


;;     :config
;;     (evil-collection-define-key 'normal 'dired-mode-map

;;       (kbd "C-c o") 'crux-open-with))
;; ;
					;      (kbd "<return") 'crux-open-with





(use-package ag)


;; Packages written by legendary emacs youtuber Protesilaos Stavrou.
;; has a phd in philosophy
;; Bestest waifu there is
(use-package denote)
(use-package logos)
(use-package pulsar)
(use-package lin)
(use-package fontaine)
(use-package cursory)
(use-package olivetti)

(use-package ess)




(add-to-list 'Info-directory-list "/usr/share/info")

(add-to-list 'Info-directory-list "/home/bkk/.config/guix/current/share/info/")

(dolist (infodir'( "/usr/share/info"
	"/home/bkk/.config/guix/current/share/info/"
	))
(add-to-list 'Info-directory-list infodir ))

;;(add-to-list infodir (lambda () (display-line-numbers-mode 0)))

;; (use-package dirvish
;;   :config
;;   (dirvish-override-dired-mode))

(use-package bongo)

(use-package nov)

(setq org-startup-with-inline-images t)
(with-eval-after-load 'geiser-guile
 (add-to-list 'geiser-guile-load-path "~/shared/git/guix/"))

(setq org-enforce-todo-dependencies t)
(setq org-agenda-dim-blocked-tasks 'invisible)

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)


  ;; (setq org-todo-keywords
  ;;           '((sequence "ASK(a)" "WAIT(w)" "RECV(r)" "|" "DONE(d)" "SUBMITTED(s)")))

;#+SEQ_TODO: ASK(a) WAIT(w) RECV(r) DONE(d) | SUBMITTED(s)

(use-package tex
  :ensure auctex)

(use-package auctex
  :defer t 
  :init
(setq TeX-auto-save t)
     (setq TeX-parse-self t)
     (setq-default TeX-master nil))


(use-package reftex
  :init
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with Emacs latex mode
)

(use-package yasnippet 
  :init
  (yas-global-mode 1))

  
(use-package flycheck) 

(use-package notmuch) 


;(use-package ox)
(use-package ox-hugo)
  ;; :ensure t   ;Auto-install the package from Melpa
  ;; :pin melpa  ;`package-archives' should already have ("melpa" . "https://melpa.org/packages/")
  ;; :after ox)

;(add-to-list 'tramp-remote-path "/run/current-system/profile/bin" t)
;(add-to-list 'tramp-remote-path "/run/current-system/profile/sbin" t)
;(rg-enable-default-bindings)



(org-babel-do-load-languages
      'org-babel-load-languages
      '((emacs-lisp . nil)
        (C . t)))

(setq-default tab-width 4)
(setq gdb-many-windows t)

(use-package markdown-mode)
(use-package prettier)
(use-package wc-mode)
(use-package js2-mode)


(use-package emmet-mode
:config
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(add-hook 'web-mode-hook  'emmet-mode) 
)

(use-package web-mode
  :config
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode)))

(use-package magit 
:custom
(magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

:config
(global-set-key (kbd "C-x g") 'magit)
  )


(use-package geiser-guile
   :config
   (evil-collection-define-key 'insert 'geiser-repl-mode-map
     (kbd "<return>") 'geiser-repl--maybe-send))


(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)
(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; (require 'vterm)
 (use-package vterm)
;;   ;:load-path  "~/shared/git/emacs-libvterm/vterm-module.so"
 
;;   )


(defun bkk/vterm ()
   (interactive)
	(evil-window-vsplit)
	(evil-window-right 1)
	(multi-vterm))

 (use-package multi-vterm 
	 :config
	 (add-hook 'vterm-mode-hook
	 		(lambda ()
	 		(setq-local evil-insert-state-cursor 'box)
	 		(evil-insert-state)))
	 (global-set-key (kbd "C-c v") 'bkk/vterm)
) 
;; (dolist (mode '(
;; 		eshell-mode-hook
;; 	      ))
;; (add-hook mode (lambda () (evil-mode 0))))

;;    (evil-collection-define-key 'insert 'eshell-mode-map
;;      (kbd "<return>") 'RET)
;;


; etq evil-emacs-state-
;   (define-key key-translation-map (kbd "RET") (kbd "RET"))


 ;	 (global-set-key (kbd "C-c v") 'eshell)





(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

