;; Import nonfree linux module.
;; (use-modules (gnu packages)
;; 	     (nongnu packages linux)
;;              (nongnu system linux-initrd))

;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

;;(use-package-modules wm stumpwm)
(use-modules
 (gnu)
 (srfi srfi-1)
 (gnu system nss)
 (gnu packages)
 (gnu services)
 (nongnu packages linux)
 (nongnu system linux-initrd))

(use-package-modules bootloaders certs ssh xorg version-control wm emacs emacs-xyz connman gnome xdisorg admin linux) 

(use-service-modules networking ssh)


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

(bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets "/dev/vda")
               (terminal-outputs '(console))))
  (file-systems (cons (file-system
                        (mount-point "/")
                        (device "/dev/vda1")
                        (type "ext4"))
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

 ;; (packages %base-packages))
 ;; (packages (append (map specification->package
 ;; 			'( "git" "connman" 
 ;;                           ;; window managers
 ;;                           "stumpwm" "emacs" "emacs-vterm" 
 ;;                           ;; terminal emulator
 ;;                           "xterm" "rxvt-unicode" "nss-certs"
 ;;                           )
 ;; 			%base-packages)))
 (packages (append (list connman network-manager
			 ;wpa_supplicant 
                     ;; window managers
                     stumpwm emacs emacs-vterm xorg-server
                     ;; terminal emulator
                     xterm rxvt-unicode nss-certs
                     )
		   %base-packages))

 ;; (services (cons *(service (connman-service-type))
 ;; 			    (connman-configuration
; )))
			     
   ;; (services (cons * (service connman-service-type
   ;;                 (connman-configuration
   ;;                  (disable-vpn? #t)))
   ;;          	   %desktop-services))

 ;; (services (cons* (service connman-service-type
 ;;                   (connman-configuration
 ;;                    (disable-vpn? #t)))
 ;;            	   %desktop-services))



 
 ;; (services (service (connman-service-type
 ;; 			    (connman-configuration
 ;; 			     (disable-vpn? #t)))))
;;			   %desktop-services)


 ;; (services (remove (lambda (service)
 ;; 		     (eq? (service-kind service) gdm-service-type))
 ;; 		   %desktop-services))
 (name-service-switch %mdns-host-lookup-nss) )
;;(services (cons (network-manager-service-type) %desktop-services))

;;       (services %desktop-services))






;; This is an operating system configuration for a VM image.
;; Modify it as you see fit and instantiate the changes by running:
;;
;;   guix system reconfigure /etc/config.scm
;;

(use-modules (gnu) (guix) (srfi srfi-1))
(use-service-modules desktop mcron networking spice ssh xorg)
(use-package-modules bootloaders certs fonts nvi
                     package-management wget xorg)

(define vm-image-motd (plain-file "motd" "
\x1b[1;37mThis is the GNU system.  Welcome!\x1b[0m

This instance of Guix is a template for virtualized environments.
You can reconfigure the whole system by adjusting /etc/config.scm
and running:

  guix system reconfigure /etc/config.scm

Run '\x1b[1;37minfo guix\x1b[0m' to browse documentation.

\x1b[1;33mConsider setting a password for the 'root' and 'guest' \
accounts.\x1b[0m
"))

;;; XXX: Xfce does not implement what is needed for the SPICE dynamic
;;; resolution to work (see:
;;; https://gitlab.xfce.org/xfce/xfce4-settings/-/issues/142).  Workaround it
;;; by manually invoking xrandr every second.
(define auto-update-resolution-crutch
  #~(job '(next-second)
         (lambda ()
           (setenv "DISPLAY" ":0.0")
           (setenv "XAUTHORITY" "/home/guest/.Xauthority")
           (execl (string-append #$xrandr "/bin/xrandr") "xrandr" "-s" "0"))
         #:user "guest"))

(operating-system
  (host-name "gnu")
  (timezone "Etc/UTC")
  (locale "en_US.utf8")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; Label for the GRUB boot menu.
  (label (string-append "GNU Guix " (package-version guix)))

  (firmware '())

  ;; Below we assume /dev/vda is the VM's hard disk.
  ;; Adjust as needed.
  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (target "/dev/vda")
               (terminal-outputs '(console))))
  (file-systems (cons (file-system
                        (mount-point "/")
                        (device "/dev/vda1")
                        (type "ext4"))
                      %base-file-systems))

  (users (cons (user-account
                (name "guest")
                (comment "GNU Guix Live")
                (password "")                     ;no password
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; Our /etc/sudoers file.  Since 'guest' initially has an empty password,
  ;; allow for password-less sudo.
  (sudoers-file (plain-file "sudoers" "\
root ALL=(ALL) ALL
%wheel ALL=NOPASSWD: ALL\n"))

  (packages (append (list font-bitstream-vera nss-certs nvi wget)
                    %base-packages))

  (services
   (append (list (service xfce-desktop-service-type)

                 ;; Choose SLiM, which is lighter than the default GDM.
                 (service slim-service-type
                          (slim-configuration
                           (auto-login? #t)
                           (default-user "guest")
                           (xorg-configuration
                            (xorg-configuration
                             ;; The QXL virtual GPU driver is added to provide
                             ;; a better SPICE experience.
                             (modules (cons xf86-video-qxl
                                            %default-xorg-modules))
                             (keyboard-layout keyboard-layout)))))

                 ;; Uncomment the line below to add an SSH server.
                 ;;(service openssh-service-type)

                 ;; Add support for the SPICE protocol, which enables dynamic
                 ;; resizing of the guest screen resolution, clipboard
                 ;; integration with the host, etc.
                 (service spice-vdagent-service-type)

                 (simple-service 'cron-jobs mcron-service-type
                                 (list auto-update-resolution-crutch))

                 ;; Use the DHCP client service rather than NetworkManager.
                 (service dhcp-client-service-type))

           ;; Remove GDM, ModemManager, NetworkManager, and wpa-supplicant,
           ;; which don't make sense in a VM.
           (remove (lambda (service)
                     (let ((type (service-kind service)))
                       (or (memq type
                                 (list gdm-service-type
                                       wpa-supplicant-service-type
                                       cups-pk-helper-service-type
                                       network-manager-service-type
                                       modem-manager-service-type))
                           (eq? 'network-manager-applet
                                (service-type-name type)))))
                   (modify-services %desktop-services
                     (login-service-type config =>
                                         (login-configuration
                                          (inherit config)
                                          (motd vm-image-motd)))))))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))

