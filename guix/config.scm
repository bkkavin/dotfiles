;; Import nonfree linux module.
(use-modules (gnu packages)
	     (nongnu packages linux)
             (nongnu system linux-initrd))

;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

(use-modules (gnu))
(use-service-modules networking ssh)
(use-package-modules screen ssh)

(operating-system

 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))

 (host-name "bkk")
 (timezone "Asia/Kolkata")
 

 ;; Boot in "legacy" BIOS mode, assuming /dev/sdX is the
 ;; target hard disk, and "my-root" is the label of the target
 ;; root file system.
 (bootloader (bootloader-configuration
	      (bootloader grub-bootloader)
	      (targets '("/dev/sda5"))))
 (file-systems (cons (file-system
		      (device (file-system-label "guix-root"))
		      (mount-point "/")
		      (type "ext4"))
		     %base-file-systems))

 ;; This is where user accounts are specified.  The "root"
 ;; account is implicit, and is initially created with the
 ;; empty password.
 (users (cons (user-account
	       (name "alice")
	       (comment "Bob's sister")
	       (group "users")

	       ;; Adding the account to the "wheel" group
	       ;; makes it a sudoer.  Adding it to "audio"
	       ;; and "video" allows the user to play sound
	       ;; and access the webcam.
	       (supplementary-groups '("wheel"
				       "audio" "video")))
	      %base-user-accounts)))






