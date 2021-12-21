(setq inhibit-startup-message t)

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
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 ("ELPA" . "http://tromey.com/elpa/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents t))


;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

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

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
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
   

(global-set-key (kbd "C-M-b") 'counsel-ibuffer)
(setq evil-undo-system 'undo-tree)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))
(use-package all-the-icons)
(use-package doom-themes)
:init(load-theme 'doom-monokai-spectrum t)

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
	 ("C-x b" . counsel-ibuffer)
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
 (define-key evil-insert-state-map (kbd "C-m") 'evil-delete-backward-char-and-join)
 (define-key evil-insert-state-map (kbd "RET") 'newline)
 (define-key evil-normal-state-map "u" 'evil-undo)
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


(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package forge)


;(message (emacs-init-time))
(add-hook 'after-init-hook (lambda () (message (emacs-init-time)))
;(global-undo-tree-mode)
;(add-hook ’evil-local-mode-hook ’turn-on-undo-tree-mode)) 
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)
