;; this is an operating system configuration for a vm image.
;; modify it as you see fit and instantiate the changes by running:
;;
;;   guix system reconfigure /etc/config.scm
;;

(use-modules (gnu) (guix) (srfi srfi-1))
(use-service-modules desktop mcron networking spice ssh xorg)
(use-package-modules bootloaders disk certs fonts nvi
                     package-management wget xorg)

(define vm-image-motd (plain-file "motd" "
\x1b[1;37mthis is the gnu system.  welcome!\x1b[0m

this instance of guix is a template for virtualized environments.
you can reconfigure the whole system by adjusting /etc/config.scm
and running:

  guix system reconfigure /etc/config.scm

run '\x1b[1;37minfo guix\x1b[0m' to browse documentation.

\x1b[1;33mconsider setting a password for the 'root' and 'guest' \
accounts.\x1b[0m
"))

;;; xxx: xfce does not implement what is needed for the spice dynamic
;;; resolution to work (see:
;;; https://gitlab.xfce.org/xfce/xfce4-settings/-/issues/142).  workaround it
;;; by manually invoking xrandr every second.
(define auto-update-resolution-crutch
  #~(job '(next-second)
         (lambda ()
           (setenv "display" ":0.0")
           (setenv "xauthority" "/home/guest/.xauthority")
           (execl (string-append #$xrandr "/bin/xrandr") "xrandr" "-s" "0"))
         #:user "guest"))

(operating-system
  (host-name "gnu")
  (timezone "etc/utc")
  (locale "en_us.utf8")
  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  ;; label for the grub boot menu.
  (label (string-append "gnu guix " (package-version guix)))

  (firmware '())

  ;; below we assume /dev/vda is the vm's hard disk.
  ;; adjust as needed.
  (bootloader (bootloader-configuration
               (bootloader grub-bootloader)
               (targets "/dev/sda1")
	      ;(terminal-outputs 'console)
	       ))


  (file-systems (cons*
		 (file-system
		   (mount-point "/")
		   (device "/dev/sda2")
		   (type "ext4")) 
		 (file-system
		   (mount-point "/gnu/store")
		   (device "/dev/sda2")
		   (type "ext4"))
		 %base-file-systems))

  (users (cons (user-account
                (name "guest")
                (comment "gnu guix live")
                (password "")                     ;no password
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; our /etc/sudoers file.  since 'guest' initially has an empty password,
  ;; allow for password-less sudo.
  (sudoers-file (plain-file "sudoers" "\
root all=(all) all
%wheel all=nopasswd: all\n"))

  (packages (append (list parted gparted font-bitstream-vera nss-certs nvi wget)
                    %base-packages))

  (services
   (append (list (service xfce-desktop-service-type)

                 ;; choose slim, which is lighter than the default gdm.
                 (service slim-service-type
                          (slim-configuration
                           (auto-login? #t)
                           (default-user "guest")
                           (xorg-configuration
                            (xorg-configuration
                             ;; the qxl virtual gpu driver is added to provide
                             ;; a better spice experience.
                             (modules (cons xf86-video-qxl
                                            %default-xorg-modules))
                             (keyboard-layout keyboard-layout)))))

                 ;; uncomment the line below to add an ssh server.
                 ;;(service openssh-service-type)

                 ;; add support for the spice protocol, which enables dynamic
                 ;; resizing of the guest screen resolution, clipboard
                 ;; integration with the host, etc.
                 (service spice-vdagent-service-type)

                 (simple-service 'cron-jobs mcron-service-type
                                 (list auto-update-resolution-crutch))

                 ;; use the dhcp client service rather than networkmanager.
                 (service dhcp-client-service-type))

           ;; remove gdm, modemmanager, networkmanager, and wpa-supplicant,
           ;; which don't make sense in a vm.
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

  ;; allow resolution of '.local' host names with mdns.
  (name-service-switch %mdns-host-lookup-nss))

;bkk
