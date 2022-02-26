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


;; (require 'org)
;; (org-babel-load-file
;;    (expand-file-name "init_bkk.org"
;;                      user-emacs-directory))

(defun package-reinstall-all-activated-packages ()
  "Refresh and reinstall all activated packages."
  (interactive)
  (package-refresh-contents)
  (dolist (package-name package-activated-list)
    (when (package-installed-p package-name)
      (unless (ignore-errors                   ;some packages may fail to install
                (package-reinstall package-name))
        (warn "Package %s failed to reinstall" package-name)))))



                     (setq inhibit-startup-message)
                      (scroll-bar-mode -1)        ; Disable visible scrollbar
                      (tool-bar-mode -1)          ; Disable the toolbar
                      (tooltip-mode -1)           ; Disable tooltips

                      (menu-bar-mode -1)         ; Disable the menu bar
                      (set-fringe-mode 10)        ; Give some breathing room


                      ;; Set up the visible bell
                      (setq visible-bell t)

                      ;(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)


                      ;; Make ESC quit prompts
                      (global-set-key (kbd "<escape>") 'keyboard-escape-quit)

                      ;; Initialize package sources
                       (require 'package)
                       (setq package-archives '(("melpa" . "https://melpa.org/packages/")
                                        ;       ("org" . "https://orgmode.org/elpa/")
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
                      (dolist (mode '(org-mode-hook))
                        (add-hook mode (lambda () (display-line-numbers-mode 0))))

                  (use-package command-log-mode)

                   (setq org-src-fontify-natively t
                       org-src-tab-acts-natively t
                      org-confirm-babel-evaluate nil
                      org-edit-src-content-indentation 0)
                          (use-package ivy
                            :diminish
                            :bind (("C-s" . swiper)
                            :map ivy-minibuffer-map
                            ("TAB" . ivy-alt-done)
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
                      (use-package doom-modeline
                        :ensure t
                        :init (doom-modeline-mode 1)
                        :custom ((doom-modeline-height 15))
                        :config  (setq doom-modeline-icon t))
                      (use-package doom-themes)
                      :init(load-theme 'doom-ir-black t)

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

                      ;;  (use-package helpful
                      ;;    :commands (helpful-callable helpful-variable helpful-command helpful-key)
                      ;;   :custom
                      ;;   (counsel-describe-function-function #'helpful-callable)
                      ;;   (counsel-describe-variable-function #'helpful-variable)
                      ;;   :bind
                      ;;   ([remap describe-function] . counsel-describe-function)
                      ;;   ([remap describe-command] . helpful-command)
                      ;;   ([remap describe-variable] . counsel-describe-variable)
                      ;;   ([remap describe-key] . helpful-key))


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
                       (define-key evil-normal-state-map (kbd "u")  'undo-only)
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

                      (use-package magit
                        :custom
                        (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

                     


                      (defun bkk/org-mode-setup ()
                        (org-indent-mode)
                      (message (emacs-init-time))
                      (variable-pitch-mode 1)
                      (visual-line-mode 1))

                      ;; Org Mode Configuration ------------------------------------------------------

                      (defun bkk/org-font-setup ()
                        ;; Replace list hyphen with dot
                        (font-lock-add-keywords 'org-mode
                                                '(("^ *\\([-]\\) "
                                                   (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

                        ;; Set faces for heading levels
                        (dolist (face '((org-level-1 . 1.2)
                                        (org-level-2 . 1.1)
                                        (org-level-3 . 1.05)
                                        (org-level-4 . 1.0)
                                        (org-level-5 . 1.1)
                                        (org-level-6 . 1.1)
                                        (org-level-7 . 1.1)
                                        (org-level-8 . 1.1)))
                          (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

                        ;; Ensure that anything that should be fixed-pitch in Org files appears that way
                        (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
                        (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
                        (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
                        (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
                        (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
                        (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
                        (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))

                      (use-package org
                        :hook (org-mode . bkk/org-mode-setup)
                        :pin manual
                        :config
                        (setq org-ellipsis " ▾")
                        (bkk/org-font-setup))
                       ;:demand t
                       ; :load-path "~/.emacs.d/elpa/org-mode/lisp")
                 
		     


                      ;; (org-babel-load-file
                      ;;  (expand-file-name "init_bkk.org"
                      ;;                    user-emacs-directory))


                      (use-package org-bullets
                        :after org
                        :hook (org-mode . org-bullets-mode)
                        :custom
                        (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

                    ;; (defun bkk/org-mode-visual-fill ()
                    ;; (setq visual-fill-column-width 100
                    ;;  visual-fill-column-center-text t)
                    ;;   (visual-fill-column-mode 1))

                    ;;    (use-package visual-fill-column
                    ;;     :hook (org-mode . bkk/org-mode-visual-fill))


                    (use-package org-roam
                      :ensure t
                      :init
                      (setq org-roam-v2-ack t)
                      :custom
                      (org-roam-directory "~/git/orgfiles/roam")
                      :bind (("C-c n l" . org-roam-buffer-toggle)
                             ("C-c n f" . org-roam-node-find)
                             ("C-c n i" . org-roam-node-insert))
                      :config
                      (org-roam-setup))


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

                        (use-package websocket
                          :after org-roam
                          :straight (:host github :repo "ahyatt/emacs-websocket" :branch "main")
                        )

                        (use-package simple-httpd
                          :after org-roam
                       )
 
                         (use-package org-roam-ui
                            :straight
                            (:host github :repo "org-roam/org-roam-ui" :branch "main" :files ("*.el" "out"))
                               :after org-roam
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;; :hook (after-init . org-roam-ui-mode)
              :config
              (setq org-roam-ui-sync-theme t
              org-roam-ui-follow t
              org-roam-ui-update-on-save t
              org-roam-ui-open-on-start nil))

               (use-package elfeed
               :ensure t
               :config
               (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
               elfeed-show-entry-switch 'display-buffer)
               :bind
               ("C-x w" . elfeed )) 
 
               (use-package elfeed-org
               :ensure t
               :config
                             ; (setq elfeed-show-entry-switch 'display-buffer)
               (setq rmh-elfeed-org-files (list "~/.emacs.d/elfeed.org")))
               (elfeed-org)
     
               (use-package elfeed-goodies
               :ensure t
               :config
               (elfeed-goodies/setup))

                ;; (setq elfeed-feeds
                ;;   '("http://nullprogram.com/feed/"
                ;;    "https://planet.emacslife.com/atom.xml"))

               




















































 




















 
