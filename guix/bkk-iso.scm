(use-modules
 (gnu) (gnu system nss)
 (nongnu packages linux)
 (nongnu system linux-initrd)
)
(use-service-modules pm desktop xorg)
(use-package-modules certs gnome lisp wm)

(operating-system
  (host-name "bkk")
  (timezone "Asia/Kolkata")
  (locale "en_US.utf8")

  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (keyboard-layout (keyboard-layout "us" "altgr-intl"))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

   (file-systems (append
                 (list (file-system
                         (device (uuid "580461b7-c685-4d25-95da-bc630b09dec1"))
                         (mount-point "/")
                         (type "ext4"))
                       (file-system
                         (device (uuid "B4BC-F364" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))

  (users (cons (user-account
                (name "bkk")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  (packages (append (list
		     ;; stumpwm
		     sbcl stumpwm `(,stumpwm "lib")
                     ;; for HTTPS access
                     nss-certs
                     ;; for user mounts
                     gvfs)
                     ;; sbcl-ttf-fonts font-dejavu
		    %base-packages))

  (services (append (list (service tlp-service-type)
			  (service thermald-service-type)
			  (service xfce-desktop-service-type)
                          (set-xorg-configuration
                           (xorg-configuration
                            (keyboard-layout keyboard-layout))))
                    %desktop-services))

  (name-service-switch %mdns-host-lookup-nss))
