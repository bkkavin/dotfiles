(define-module (gnu packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages adns)
  #:use-module (gnu packages aidc)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages dbm)
  #:use-module (gnu packages digest)
  #:use-module (gnu packages django)
  #:use-module (gnu packages djvu)
  #:use-module (gnu packages docker)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages enchant)
  #:use-module (gnu packages file)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gdb)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gsasl)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu packages image)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages java)
  #:use-module (gnu packages jupyter)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libidn)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages man)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages monitoring)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages node)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages openstack)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages python-compression)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages regex)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages scanner)
  #:use-module (gnu packages search)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wxwidgets)
  #:use-module (gnu packages base)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages bdw-gc)
  #:use-module (gnu packages serialization)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26))

(define-public python-ueberzug
  (package
    (name "python-ueberzug")
    (version "18.1.9")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ueberzug" version))
       (sha256
        (base32
         "1hxd45dnwa9yv908acarr98n2drmar66wzq9z2qd3irj24srzr3w"))))
    (build-system python-build-system)
    (inputs
     (list libx11 libxext))
    (propagated-inputs
     (list python-attrs python-docopt python-pillow python-xlib))
    (home-page "https://github.com/seebye/ueberzug")
    (synopsis "Command line util to display images in combination with X11")
    (description "Überzug is a command line util which draws images on
terminals by using child windows.  The advantages of using Überzug are:
@itemize
@item No race conditions as a new window is created to display images.
@item Expose events will be processed, so images will be redrawn on switch
workspaces.
@item Tmux support (excluding multi pane windows).
@item Terminals without the WINDOWID environment variable are supported.
@item Chars are used as position - and size unit.
@item No memory leak (/ unlimited cache).
@end itemize")
    (license license:gpl3+)))

(define-public python-ubelt
  (package
    (name "python-ubelt")
    (version "1.0.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Erotemic/ubelt")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0hac9nqqvqfbca2s4g0mp1fnj0ah60bg9fb8234ibna3jww8qs33"))))
    (build-system python-build-system)))

(define-public hut
  (package
    (name "hut")
    (version "0.2.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~emersion/hut")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0ybngrwwmkm00dlkdhvkfcvcjhp5xzs8fh90zqr0h12ssqx9pll3"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "git.sr.ht/~emersion/hut"
      #:phases
      #~(modify-phases %standard-phases
          (replace 'build
            (lambda* (#:key import-path #:allow-other-keys)
              (with-directory-excursion (string-append "src/" import-path)
                ;; The flags are copied from (guix build go-build-system).
                (setenv "CGO_LDFLAGS" "-s -w")
                (invoke "make" "all" "GOFLAGS=-v -x"))))
          (replace 'install
            (lambda* (#:key import-path #:allow-other-keys)
              (with-directory-excursion (string-append "src/" import-path)
                (invoke "make" "install"
                        (string-append "PREFIX=" #$output))))))))
    (native-inputs
     (list scdoc))
    (inputs
     (list go-git-sr-ht-emersion-go-scfg
           go-git-sr-ht-emersion-gqlclient
           go-github-com-juju-ansiterm
           go-github-com-spf13-cobra
           go-golang-org-x-oauth2
           go-golang-org-x-term))
    (home-page "https://git.sr.ht/~emersion/hut")
    (synopsis "CLI tool for sr.ht")
    (description "@command{hut} is a CLI tool for
@uref{https://sr.ht/~sircmpwn/sourcehut/, sr.ht}.  It helps you interact with
sr.ht's public services:
@table @asis
@item builds
submit and manage build jobs
@item git
create, and manage git repositories and artifacts
@item hg
list Mercurial repositories
@item lists
manage mailing lists and patches
@item meta
manage PGP, and SSH keys
@item pages
publish and manage hosted websites
@item paste
create and manage pastes
@item todo
create and manage trackers, tickets
@item graphql
interact with GraphQL APIs directly
@end table")
    (license license:agpl3)))




    (define-public hub-sr-ht 
  (package
    (name "hub-sr-ht")
    (version "0.16.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~sircmpwn/hub.sr.ht")
             (commit (string-append "v" version))))
       (sha256
        (base32
         "095f3gwpfr9ijcf0miyqnj8nqxxnnc5vc7yij4axx59lpy6lal49"))))
    (build-system python-build-system)
    (inputs
     (list libx11 libxext))
    (propagated-inputs
     (list python-attrs python-docopt python-pillow python-xlib))
    (home-page "https://github.com/seebye/ueberzug")
    (synopsis "Command line util to display images in combination with X11")
    (description "Überzug is a command line util which draws images on
terminals by using child windows.  The advantages of using Überzug are:
@itemize
@item No race conditions as a new window is created to display images.
@item Expose events will be processed, so images will be redrawn on switch
workspaces.
@item Tmux support (excluding multi pane windows).
@item Terminals without the WINDOWID environment variable are supported.
@item Chars are used as position - and size unit.
@item No memory leak (/ unlimited cache).
@end itemize")
    (license license:gpl3+)))

