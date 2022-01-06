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
import XMonad.Actions.Submap


import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig 
import XMonad.Util.NamedScratchpad
--import XMonad.Hooks.EwmhDesktops



myLayoutHook = ThreeCol 1 (3/100) (1/2)  |||  noBorders(Full)  ||| centerMaster Grid   
myTerminal = "urxvt"
myModMask  = mod4Mask
myManageHook = manageSpawn <+> manageHook def<+> namedScratchpadManageHook myScratchPads

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "ecx" spawnECX findECX manageECX 
                ]
  where
    spawnTerm  = "~/urxvtc.sh -name scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
               
    spawnECX = "./ecx.sh"
    findECX  = title =? "ecx"
    manageECX = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w


myStartupHook = do
                spawnAndDo (doRectFloat (W.RationalRect 0.1 0.1 0.4 0.8) <+> doShift "1") "emacs" 
         --     spawnOn "2" "emacs"
                spawnOn "2" "brave"
         --     spawnOn "4" "urxvt"
                spawnAndDo (doRectFloat (W.RationalRect 0.55 0.1 0.4 0.8) <+> doShift "1") "urxvt -hold" 


myKeys :: [(String, X ())]
myKeys = 
        [ ("M-C-r", spawn "xmonad --recompile")       -- Recompiles xmonad
        , ("C-M-t", namedScratchpadAction myScratchPads "terminal")
        , ("C-M-e", namedScratchpadAction myScratchPads "ecx")

        ]



main :: IO ()
main = do
xmproc <- spawnPipe "xmobar -x 0 ~/.xmobarrc"
xmonad  $ def
      {terminal            = myTerminal
  {-  ,  focusFollowsMouse  = myFocusFollowsMouse
      ,  clickJustFocuses   = myClickJustFocuses
      ,  borderWidth        = myBorderWidth            -}
      ,  modMask            = myModMask
  {-  ,  workspaces         = myWorkspaces
      ,  normalBorderColor  = myNormalBorderColor
      ,  focusedBorderColor = myFocusedBorderColor    -} 

      -- key bindings
  --  , keys               = myKeys
  --  , mouseBindings      = myMouseBindings           

      -- hooks, layouts
      , layoutHook         = myLayoutHook
      , manageHook         = myManageHook
  {-  , handleEventHook    = myEventHook 
      , logHook            = myLogHook                  -}
      ,  startupHook       = myStartupHook
      }
      `additionalKeysP` myKeys




























  {-  spawnAndDo (doRectFloat (W.RationalRect 0.05 0.1 0.4 0.8) <+> doShift "1") "emacs" 
                spawnOnce "urxvtd -q -o -f" 
                spawnAndDo (doRectFloat (W.RationalRect 0.5 0.1 0.4 0.8) <+> doShift "1") "urxvtd -q -o -f  && urxvtc -hold -e ~/fun.sh"  
               spawnOn "1" "emacsclient -a "" -nc -F '(quote (name . \"emacs-bkk\"))'" -}
            

{-

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mocp" spawnMocp findMocp manageMocp
                 ]
		 
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w

-}