(in-package :stumpwm)
(define-key *root-map* (kbd "C-c") "exec urxvt") 
(define-key *root-map* (kbd "C-b") "brave-bkk") 
;;(define-key *root-map* (kbd "C-b") "exec brave-browser-stable") 
(define-key *root-map* (kbd "b") "exec ebook-viewer")
(define-key *root-map* (kbd "C-e") "exec nyxt ")
(define-key *root-map* (kbd "e") "emacs-bkk")
(define-key *root-map* (kbd "w") "windowlist")
(define-key *groups-map* (kbd "g") "grouplist")
;; (define-key *root-map* (kbd "e") "exec emacsclient -nc --socket-name=stumpwm")
;; (define-key *root-map* (kbd "c") "exec emacsclient -nc --socket-name=stumpwm -e '(vterm)' ")
;;

; (fill-keymap *root-map*
;;   (kbd "c")   "exec urxvt"
;;   (kbd "C-c") "exec xterm")
(run-shell-command "compton &")
(run-shell-command "xwallpaper --zoom ~/Pictures/lots-of-trees.jpg")
(init-load-path #p"~/.stumpwm.d/modules") 
	     
(load-module "swm-gaps")
;;(load-module "binwarp")
;; Head gaps run along the 4 borders of the monitor(s)
(setf swm-gaps:*head-gaps-size* 10)

;; Inner gaps run along all the 4 borders of a window
(setf swm-gaps:*inner-gaps-size* 10)


;; Outer gaps add more padding to the outermost borders of a window (touching
;; the screen border)
(setf swm-gaps:*outer-gaps-size* 15)

;; Call command
;; toggle-gaps
;;(set-border-colour "#00AAAA")
;; modeline
(setq *mode-line-background-color* "#002222" )
(setq *mode-line-foreground-color* "#999999")
(setq *mode-line-border-color* "#009999")
(set-font "Hack")

(when *initializing*
  (run-shell-command "emacs --daemon=stumpwm && emacsclient -nc --socket-name=stumpwm -e '(vterm)'q")
    
;  (swm-gaps:toggle-gaps)
  (mode-line)
  (grename "emacs")
  (gnewbg "web")
  (gnewbg "book"))


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

(defcommand emacs-bkk () () (gselect "emacs")(run-or-raise "emacsclient -nc --socket-name=stumpwm -e '(vterm)'" '(:class "Emacs")))

;;(load-module :stumpwm-base16)

(defcommand brave-bkk ()()(gselect "web")(run-or-raise "brave-browser" '(:class "Brave-browser")))

	    



;; (defcommand emacs-bkk () ()
;; 	    ((run-or-raise "emacsclient -nc --socket-name=stumpwm" '(:class "Emacs"))
;; 	     (let emacsbkk (current-window)
;; 	    (select emacsbkk))

;; 	    (gmove-and-follow ".emacs")))'
;; ;;(load-module :stumpwm-base16)

;; (defcommand brave-bkk ()()(
;; 			   (run-or-raise "brave-browser" '(:class "Brave-browser"))
;; 			   (gmove-and-follow "web")
;; 			   ))
	
