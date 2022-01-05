import XMonad
import Data.Monoid
import System.Exit


import qualified XMonad.StackSet as W
import qualified Data.Map        as M


import XMonad.Actions.SpawnOn


import XMonad.Layout
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Fullscreen
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.CenteredMaster
import XMonad.Layout.Grid
import XMonad.Layout.Renamed
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Hooks.ManageDocks
import XMonad.Util.NamedScratchpad
import XMonad.ManageHook
import XMonad.Util.EZConfig




myLayoutHook = ThreeCol 1 (3/100) (2/3)  |||  noBorders(Full)  ||| centerMaster Grid   
myTerminal = "urxvt"
myModMask  = mod4Mask
myManageHook = manageSpawn <+> manageHook def <+> namedScratchpadManageHook scratchpads 


myStartupHook = do
                spawnOn "2" "emacs"
                spawnAndDo (doShift "3") "brave" 
                {- spawnOn "3" "brave" -}
                spawnOn "4" "urxvt"
                spawnAndDo (doRectFloat (W.RationalRect 0.05 0.1 0.4 0.8) <+> doShift "1") "emacs" 

mykeys = \c -> mkKeymap c $
    [  ("M-S-<Return>", namedScratchpadAction scratchpads "scratchpad")
    ,  ("M-S-<Space>", namedScratchpadAction scratchpads "emacs-scratchpad")

{-  , ("M-x w", spawn "xmessage 'woohoo!'")  -- type mod+x then w to pop up 'woohoo!'
    , ("M-x y", spawn "xmessage 'yay!'")     -- type mod+x then y to pop up 'yay!'
    , ("M-S-c", kill) -}
    ]



scratchpads :: [NamedScratchpad]
scratchpads = [ NS "terminal" spawmTerm findTerm manageTerm
             ,  NS "emacs-scratch" spawnEmacsScratch findEmacsScratch manageEmacsScratch
              ]

where
spawnTerm = myTerminal ++ " -name scratchpad"
findTerm = resource =? "scratchpad"
manage = nonFloating
findEmacsScratch = title =? "emacs-scratch"
spawnEmacsScratch = "emacsclient -a' ' -nc -F=' (quote (name . \"emacs-scratch\"))'"
manageEmacsScratch = nonFloating

main :: IO ()
main = do
xmproc <- spawnPipe "xmobar -x 0 ~/.xmobarrc"
xmonad def
       {terminal           = myTerminal
  {-  ,  focusFollowsMouse  = myFocusFollowsMouse
      ,  clickJustFocuses   = myClickJustFocuses
      ,  borderWidth        = myBorderWidth            -}
      ,  modMask            = myModMask
  {-  ,  workspaces         = myWorkspaces
      ,  normalBorderColor  = myNormalBorderColor
      ,  focusedBorderColor = myFocusedBorderColor     -}

      -- key bindings
      ,  keys               = myKeys
  {-  , mouseBindings      = myMouseBindings           -}

      -- hooks, layouts
      , layoutHook         = myLayoutHook
      , manageHook         = myManageHook
  {-  , handleEventHook    = myEventHook 
      , logHook            = myLogHook                  -}
      ,  startupHook    = myStartupHook
        }

{-

scratchpads :: [NamedScratchpad]
scratchpads = [ NS "terminal" spawmTerm findTerm manageTerm
             ,  NS "emacs-scratch" spawnEmacsScratch findEmacsScratch manageEmacsScratch
              ]

where
spawnTerm = myTerminal ++ " -name scratchpad"
findTerm = resource =? "scratchpad"
manage = nonFloating
findEmacsScratch = title =? "emacs-scratch"
spawnEmacsScratch = "emacsclient -a' ' -nc -F=' (quote (name . \"emacs-scratch\"))'"
manageEmacsScratch = nonFloating
-}
{- scratchpads = [
{- -- run htop in xterm, find it by title, use default floating window placement
    NS "htop" "xterm -e htop" (title =? "htop") defaultFloating , -} 

-- run stardict, find it by class name, place it in the floating window
-- 1/6 of screen width from the left, 1/6 of screen height
-- from the top, 2/3 of screen width by 2/3 of screen height 
        NS "emacs" "emacs" (className =? "emacs") nonFloating
      {-  (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))  -}

{- -- run gvim, find by role, don't float
    NS "notes" "gvim --role notes ~/notes.txt" (role =? "notes") nonFloating -}
] {- where role = stringProperty "WM_WINDOW_ROLE" -}

-}

{-
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
         [   ((modm .|. controlMask .|. shiftMask, xK_e), namedScratchpadAction scratchpads "emacs-scratch")
           , ((modm .|. controlMask .|. shiftMask, xK_t), namedScratchpadAction scratchpads "scratchpad")
     {-    , ((modm .|. controlMask .|. shiftMask, xK_n), namedScratchpadAction scratchpads "notes")       -}
         ]

-}

