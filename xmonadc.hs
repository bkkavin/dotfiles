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



myLayoutHook = ThreeCol 1 (3/100) (1/2)  |||  noBorders(Full)  ||| centerMaster Grid   
myTerminal = "urxvt"
myModMask  = mod4Mask
myManageHook = manageSpawn <+> manageHook def 


myStartupHook = do
                spawnAndDo (doRectFloat (W.RationalRect 0.1 0.1 0.4 0.8)) "emacs" 
                spawnOn "2" "emacs"
                spawnOn "3" "brave"
                spawnOn "4" "urxvt"
                spawnOn "1" "~/urxvtc.sh -hold -e ~/fun.sh" 
                spawnOn "5" "~/ecx.sh"





main :: IO ()
main = do
xmproc <- spawnPipe "xmobar -x 0 ~/.xmobarrc"
xmonad def
       {terminal            = myTerminal
  {-  ,  focusFollowsMouse  = myFocusFollowsMouse
      ,  clickJustFocuses   = myClickJustFocuses
      ,  borderWidth        = myBorderWidth            -}
      ,  modMask            = myModMask
  {-  ,  workspaces         = myWorkspaces
      ,  normalBorderColor  = myNormalBorderColor
      ,  focusedBorderColor = myFocusedBorderColor     

      -- key bindings
     ,  keys               = myKeys
      , mouseBindings      = myMouseBindings           -}

      -- hooks, layouts
      , layoutHook         = myLayoutHook
      , manageHook         = myManageHook
  {-  , handleEventHook    = myEventHook 
      , logHook            = myLogHook                  -}
      ,  startupHook       = myStartupHook
       }

  {-  spawnAndDo (doRectFloat (W.RationalRect 0.05 0.1 0.4 0.8) <+> doShift "1") "emacs" 
                spawnOnce "urxvtd -q -o -f" 
                spawnAndDo (doRectFloat (W.RationalRect 0.5 0.1 0.4 0.8) <+> doShift "1") "urxvtd -q -o -f  && urxvtc -hold -e ~/fun.sh"  
               spawnOn "1" "emacsclient -a "" -nc -F '(quote (name . \"emacs-bkk\"))'" -}
            
