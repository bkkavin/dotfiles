 (defvar bootstrap-version)
 (let ((bootstrap-file
 (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
 (bootstrap-version 5))
 (unless (file-exists-p bootstrap-file)
 (with-current-buffer
 (url-retrieve-synchronously
 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
 'silent 'inhibit-cookies)
 (goto-char (point-max))
 (eval-print-last-sexp)))
 (load bootstrap-file nil 'nomessage))


(require 'org)
(org-babel-load-file
   (expand-file-name "init_bkk.org"
                     user-emacs-directory))

(defun package-reinstall-all-activated-packages ()
  "Refresh and reinstall all activated packages."
  (interactive)
  (package-refresh-contents)
  (dolist (package-name package-activated-list)
    (when (package-installed-p package-name)
      (unless (ignore-errors                   ;some packages may fail to install
                (package-reinstall package-name))
        (warn "Package %s failed to reinstall" package-name)))))
