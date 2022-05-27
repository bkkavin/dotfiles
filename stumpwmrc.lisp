(in-package :stumpwm)
(define-key *root-map* (kbd "c") "exec urxvt") 
(define-key *root-map* (kbd "C-b") "exec brave-browser-stable") 
(define-key *root-map* (kbd "b") "exec ebook-viewer")
(define-key *root-map* (kbd "C-e") "exec nyxt ")
(define-key *root-map* (kbd "e") "exec emacsclient -nc --socket-name=stumpwm")

;; (fill-keymap *root-map*
;;   (kbd "c")   "exec urxvt"
;;   (kbd "C-c") "exec xterm")

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

(when *initializing*
  (run-shell-command "emacs --daemon=stumpwm")
;  (swm-gaps:toggle-gaps)
  (mode-line)
  (gnewbg ".emacs") 
  (gnewbg ".term")
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

		       
		       

;;(load-module :stumpwm-base16)

(run-shell-command "xwallpaper --zoom ~/Pictures/lots-of-trees.jpg")
(run-shell-command "compton &")


