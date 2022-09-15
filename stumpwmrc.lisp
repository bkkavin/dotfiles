(in-package :stumpwm)
(load-module "spatial-groups")
(spatial-groups:install-default-keybinds)
(gkill-other)

(run-shell-command "picom &")
(run-shell-command "xwallpaper --zoom ~/pix/lots-of-trees.jpg")
(init-load-path #p"/home/bkk/.stumpwm.d/modules") 
(run-shell-command "exec emacsclient -nc -a '' -e '(multi-vterm)'")
(define-key *root-map* (kbd "b") "exec brave") 
(define-key *root-map* (kbd "C-b") "exec ebook-viewer")
(define-key *root-map* (kbd "C-e") "exec nyxt ")
;;(define-key *root-map* (kbd "e") "emacs-bkk")
(define-key *root-map* (kbd "e") "exec rofi -show run")
(define-key *root-map* (kbd "e") "exec emacsclient -nc -a '' -e '(multi-vterm)'")
(define-key *root-map* (kbd "w") "windowlist")
(define-key *groups-map* (kbd "g") "grouplist")
(define-key *root-map* (kbd "l") "exec rofi -show run")
(define-key *root-map* (kbd "T") "send-raw-key")
;; (defcommand send-C-t () () 
;;     (send-raw-key "C-t"))


					; (fill-keymap *root-map*
;;   (kbd "c")   "exec urxvt"
;;   (kbd "C-c") "exec xterm")

(load-module "swm-gaps")
;;("toggle-gaps-on")

;; ;;(load-module "binwarp")
;; ;; Head gaps run along the 4 borders of the monitor(s)
;; (setf swm-gaps:*head-gaps-size* 10)

;; ;; Inner gaps run along all the 4 borders of a window
;; (setf swm-gaps:*inner-gaps-size* 10)

;; ;; Outer gaps add more padding to the outermost borders of a window (touching
;; ;; the screen border)
;; (setf swm-gaps:*outer-gaps-size* 15)

;; Call command
;;(toggle-gaps-on)
;;(set-border-colour "#00AAAA")
;; modeline
(setq *mode-line-background-color* "#002222" )
(setq *mode-line-foreground-color* "#999999")
(setq *mode-line-border-color* "#009999")
(set-font "Hack")

;; (when *initializing*
;;   (run-shell-command "emacs --daemon=stumpwm && emacsclient -nc --socket-name=stumpwm -e '(vterm)'")
;; 					;  (swm-gaps:toggle-gaps)
;;   (mode-line))
 ;; (when *initializing*
;;    (run-shell-command "emacs --daemon && exec emacsclient -nc -a '' -e '(vterm)'")
;;  					;  (swm-gaps:toggle-gaps)

;; ;;   (run-shell-command "emacs --daemon && ")

;;    (mode-line))



;; Message & input window
(setq *message-window-gravity* :center)
(setq *message-window-input-gravity* :center)
(setq *input-window-gravity* :center)
(set-border-color "#00AAAA")
(set-win-bg-color "#000000")
(set-focus-color "#002222")					;
;;(set-unfocus-color "#000000")					;
(setq *window-border-style* :thick)
(defparameter *normal-border-width* 5)
;;(setq *which-key-mode* t)

					;(act-on-matching-windows (:screen 0)) 
;;(move-windows-to-group :class ("emacs") ".emacs")

;;

;;(defcommand emacs-bkk () () (run-or-raise "emacsclient -nc --socket-name=stumpwm -e '(vterm)'" '(:class "Emacs")))

;;(load-module :stumpwm-base16)






;; (defcommand emacs-bkk () ()
;; 	    ((run-or-raise "emacsclient -nc --socket-name=stumpwm" '(:class "Emacs"))
;; 	     (let emacsbkk (current-window)
;; 	    (select emacsbkk))

;; 	    (gmove-and-follow ".emacs")))'
;; ;;(load-module :stumpwm-base16)

;;(load-module :stumpwm-base16)

(load-module "net")

 (mode-line)
;; (load-module "battery-portable")

;; ;; Disk space on modeline
;; (ql:quickload "cl-diskspace")
;; ;; on GNU/linux only
;; (ql:quickload "cl-mount-info")
;; (load-module "disk")



;;(load-module "cpu")

 ;; (load-module "mem")
 ;; (load-module "wifi")
 ;; (load-module "end-session")
;(load-module "lookup")
;; (load-module "screenshots")
;;  (load-module "searchengines")
;;  (load-module "stump-lock")
;;  (load-module "stump-nm") 
;;
(load-module "undocumented") 
(load-module "winner-mode") 
(defvar *winner-map* (make-sparse-keymap))
(define-key *root-map* (kbd "w") '*winner-map*)
(define-key *winner-map* (kbd "n") "winner-undo")
(define-key *winner-map* (kbd "p") "winner-redo")
(add-hook *post-command-hook* (lambda (command)
                                (when (member command winner-mode:*default-commands*)
                                  (winner-mode:dump-group-to-file))))
;; ;
					; (defcommand brave-bkk ()()(
;; 			   (run-or-raise "brave-browser" '(:class "Brave-browser"))
;; 			   (gmove-and-follow "web")
;; 			   ))

(load-module "app-menu")
(setq app-menu:*app-menu*
      '(("BROWSER"
         ;; submenu
         ;;("Firefox" firefox)       ; call stumpwm command
         ;;("Skype" "skypeforlinux") ; run shell script

         ("Brave" brave-bkk)       ; call stumpwm command
	 ("Chrome" "google-chrome-stable")
         )
	("CONFIG"
	 ("stumpwm" "cp ~/git/dotfiles/stumpwmrc.lisp ~/.config/stumpwm/config")
	 ("emacs" "cp ~/git/dotfiles/emacs/init_bkk.org ~/.emacs.d/init_bkk.org")

	 )))


;; ("WORK"
;;  ("OpenOffice.org"  "openoffice"))
;; ("GRAPHICS"
;;  ("GIMP" "gimp")
;;  ("Inkscape" "inkscape"))
;; ("urxvt" urxvt)
;; ("K3B" "k3b")))
;;(load-module :swm-emacs) 
;; (setf stumpwm:*screen-mode-line-format*
;;       (list  "%w | %C %l"
;;              '(:eval (stumpwm:run-shell-command "date" t)))) 


;; (defvar *spatial-map* (make-sparse-keymap))

;; (define-key *root-map* (kbd "C-t") '*spatial-map*)
;;   ;; (define-key *spatial-map* (kbd "S-p")      "move-focus up")
;;   ;; (define-key *spatial-map* (kbd "S-n")    "move-focus down")
;;   ;; (define-key *spatial-map* (kbd "S-b")    "move-focus left")
;;   ;; (define-key *spatial-map* (kbd "S-f")   "move-focus right")

;;   ;; Control arrows move between screens on the current desktop
;;   (define-key *spatial-map* (kbd "b")    "coord-left")
;;   (define-key *spatial-map* (kbd "f")   "coord-right")
;;   (define-key *spatial-map* (kbd "p")      "coord-up")
;;   (define-key *spatial-map* (kbd "n")    "coord-down")

  ;; Control-Shift left/right to switch desktop Z
;  (define-key *spatial-map* (kbd "s-B")  "coord-taskleft")
;  (define-key *spatial-map* (kbd "s-F") "coord-taskright")

  ;; Control-Shift-Up to return to origin 0,0 on current desktop Z
;  (define-key *spatial-map* (kbd "s-P")    "coord-taskorigin")

  ;; "Pop" back to last desktop position
;  (define-key *spatial-map* (kbd "N")  "coord-taskpop") 

  (define-key *top-map* (kbd "s-h")    "coord-left")
  (define-key *top-map* (kbd "s-l")   "coord-right")
  (define-key *top-map* (kbd "s-k")      "coord-up")
  (define-key *top-map* (kbd "s-j")    "coord-down")

  ;; Control-Shift left/right to switch desktop Z
  (define-key *top-map* (kbd "s-H")  "coord-taskleft")
  (define-key *top-map* (kbd "s-L") "coord-taskright")

  ;; Control-Shift-Up to return to origin 0,0 on current desktop Z
  (define-key *top-map* (kbd "s-K")    "coord-taskorigin")

  ;; "Pop" back to last desktop position
  (define-key *top-map* (kbd "s-L")  "coord-taskpop") 

;; (defcommand brave-bkk ()() (run-or-raise "brave-browser" '(:class "Brave-browser")))
;; (define-key *root-map* (kbd "b") "brave-bkk") 
