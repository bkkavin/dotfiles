;; Import nonfree linux module.
;; (use-modules (gnu packages)
;; 	     (nongnu packages linux)
;;              (nongnu system linux-initrd))

;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.


(use-modules
 (gnu)
 (gnu system nss)
 (gnu packages)
 (nongnu packages linux)
 (nongnu system linux-initrd))

(use-service-modules networking ssh)
 (use-package-modules bootloaders certs ssh xorg version-control wm stumpwm emacs emacs-xyz) 


(operating-system


 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (host-name "bkk")
 (timezone "Asia/Kolkata")
 (locale "en_US.utf8")

 ;; Boot in "legacy" BIOS mode, assuming /dev/sdX is the
 ;; target hard disk, and "my-root" is the label of the target
 ;; root file system.
 (bootloader (bootloader-configuration (bootloader grub-efi-bootloader)
				       (targets '("/boot/efi"))))  ;; /dev/sda5"

(file-systems (append
	       (list(file-system
		     (device (uuid "eb7c3c6d-13b0-4e6e-ad24-64633c61b9ba")) 
		     (mount-point "/")
		     (type "ext4")))
		    ;; (file-system
		    ;;  (device (file-system-label "guix-efi"))
		    ;;  (mount-point "/boot/efi")
		    ;;  (type "vfat")))
	       %base-file-systems))

 ;; This is where user accounts are specified.  The "root"
 ;; account is implicit, and is initially created with the
 ;; empty password.
 (users (cons (user-account
	       (name "bkk")
	       (comment "B K Kavin")
	       (group "users")

	       ;; Adding the account to the "wheel" group
	       ;; makes it a sudoer.  Adding it to "audio"
	       ;; and "video" allows the user to play sound
	       ;; and access the webcam.
	       (supplementary-groups '("wheel"
				       "audio" "video")))
	      %base-user-accounts))


       (packages (append (map specification->package
		       '( "git" "network-manager" 
                          ;; window managers
                          "stumpwm" "emacs" "emacs-vterm" 
                          ;; terminal emulator
                          "xterm" "rxvt-unicode" "nss-certs"
                          )
                         %base-packages))) 

       (services %desktop-services))




