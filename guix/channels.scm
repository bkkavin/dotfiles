;; (cons* (channel
;;         (name 'nonguix)
;;         (url "https://gitlab.com/nonguix/nonguix")
;;         ;; enable signature verification:
;;         (introduction
;;          (make-channel-introduction
;;           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
;;           (openpgp-fingerprint
;;            "2a39 3fff 68f4 ef7a 3d29  12af 6f51 20a0 22fb b2d5"))))
;;        %default-channels)

(use-modules (guix ci)
             (guix channels))

(cons*
 (channel
  (name 'rrr)
  (url "https://git.sr.ht/~akagi/rrr")
  (introduction
   (make-channel-introduction
    "794d6e5eb362bfcf81ada12b6a49a0cd55c8e031"
    (openpgp-fingerprint
     "FF72 877C 4F21 FC4D 467D  20C4 DCCB 5255 2098 B6C1"))))
 (channel
  (name 'rde)
  (url "https://git.sr.ht/~abcdw/rde")
  (introduction
   (make-channel-introduction
    "257cebd587b66e4d865b3537a9a88cccd7107c95"
    (openpgp-fingerprint
     "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
 (channel
  (name 'nonguix)
  (url "https://gitlab.com/nonguix/nonguix")
  (introduction
   (make-channel-introduction
    "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
    (openpgp-fingerprint
     "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
 %default-channels)
