;(doom-modeline-mode)

(setq modus-themes-deuteranopia t
      modus-themes-italic-constructs nil
      modus-themes-bold-constructs nil
      
      modus-themes-mixed-fonts  nil

      modus-themes-syntax '(
			   ; faint
			   ; alt-syntax
			     green-strings
			     yellow-comments
			    )   

      modus-themes-fringes nil		; {nil,'subtle,'intense}

      ;; Options for `modus-themes-lang-checkers' are either nil (the
      ;; default), or a list of properties that may include any of those
      ;; symbols: `straight-underline', `text-also', `background',
      ;; `intense' OR `faint'.
      modus-themes-lang-checkers nil

      ;; Options for `modus-themes-mode-line' are either nil, or a list
      ;; that can combine any of `3d' OR `moody', `borderless',
      ;; `accented', a natural number for extra padding (or a cons cell
      ;; of padding and NATNUM), and a floating point for the height of
      ;; the text relative to the base font size (or a cons cell of
      ;; height and FLOAT)

      modus-themes-mode-line '(
			   ;    accented
			       borderless
    			       (padding . 4) (height . 0.9)
			      )

     modus-themes-hl-line '(accented)

     modus-themes-paren-match '(
				 bold
				 intense
                                 underline
				) 
      modus-themes-intense-mouseovers t 

     modus-themes-markup '(
			    bold
			   ;italic
			   ;background
			   ;intense
			   )

     modus-themes-region '(
			    no-extend
			    bg-only
			    accented
			   ) 
      
      modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

)
(load-theme 'modus-vivendi)
