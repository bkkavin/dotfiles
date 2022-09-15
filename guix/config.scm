(use-modules
 (gnu)
 (srfi srfi-1)
 (gnu system nss)
 (gnu system file-systems)
 (gnu packages)
 (gnu services)
; (nongnu packages linux)
; (nongnu system linux-initrd)
 )

(use-package-modules pdf fonts bootloaders certs ssh xorg version-control wm emacs emacs-xyz lisp connman gnome xdisorg admin linux) 

(use-service-modules desktop xorg base networking ssh)


(operating-system

 ;; (kernel linux)
 ;; (initrd microcode-initrd)
 ;; (firmware (list linux-firmware))

 (host-name "bkk")
 (timezone "Asia/Kolkata")
 (locale "en_US.utf8")

 ;; Boot in "legacy" BIOS mode, assuming /dev/sdX is the
 ;; target hard disk, and "my-root" is the label of the target
 ;; root file system.
 (bootloader (bootloader-configuration (bootloader grub-efi-bootloader)
				       (targets '("/boot/efi"))))  

 (file-systems (append
		(list(file-system
		      (type "ext4")
		      (device "/dev/sda3")
		      (mount-point "/")
		      (needed-for-boot? #t)
		      (device(uuid "9c4ccbd8-30f4-4be1-9e91-a9b557d7d1e1"))))
		      %base-file-systems))

	       
;(services %base-services)
 ;; (services (append (list (service lightdm-service-type
 ;; 				  (lightdm-configuration
 ;; 				   (allow-empty-passwords? #t ))))
 ;; 		   %desktop-services))

;(services %desktop-services)
 ;; (services (append (list (service gdm-service-type)
 ;; 			 (elogind-service)
 ;; 			 (service wpa-supplicant-service-type)
 ;; 			 (service connman-service-type))
 ;; 	   ;; (gdm-configuration
 ;; 	   ;;  (x-session "~/.xinitrc"))
 ;; 	   %base-services))

(users (cons (user-account
	       (name "bkk")
	       (comment "B K Kavin")
	       (group "users")
	       (supplementary-groups '("wheel"
       				       "audio" "video")))
	      %base-user-accounts))
;(services %desktop-services)
;(services xorg-start-command)

(packages (append (list  
                     ;; StumpWM
		     sbcl stumpwm `(,stumpwm "lib")
		     ;; Emacs
                     emacs emacs-vterm xorg-server
                     ;; terminal emulator
                     xterm rxvt-unicode nss-certs
                     ;;pdf
		     zathura zathura-pdf-mupdf
		  %base-packages)))


(name-service-switch %mdns-host-lookup-nss) )


