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




main :: IO ()
main = xmonad defaults
defaults = def 
       {terminal           = myTerminal,
        {- focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,-}
        modMask            = myModMask,
        {-workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,-}

      -- hooks, layouts
        layoutHook         = myLayoutHook,
        manageHook         = myManageHook, 
       {-  handleEventHook    = myEventHook
       logHook            = myLogHook -}
        startupHook        = myStartupHook
        }


myLayoutHook = noBorders(Full) |||  ThreeCol 1 (3/100) (1/3) {-||| ThreeColMid 1 (3/100) (1/2) -} ||| magnifier (Tall 1 (3/100) (1/2)) 
myTerminal = "urxvt"
myModMask  = mod4Mask
{-myManageHook =+ {- manageSpawn <+> -}  manageHook def {- <+> composeOne -}
              [appName =? "emacs" --> doRectFloat (W.RationalRect 0.25 0.25 0.5 0.5)]  -}


myStartupHook = do

{-spawnAndDo manageSpawn "emacs" -}

spawnOn "1" "emacs"
spawnOn "2" "brave"
spawnOn "3" "urxvt"
{-spawnOn "4" "urxvt ~/echo.sh" -}



{-manageHook :: manageHook
manageHook = composeAll
-}
   

{- myManageHook :: ManageHook                                      
myManageHook = composeAll $
[ className =? "emacs" --> doRectFloat ({- RationalRect -}(1 % 4) (1 % 4) (1 % 2) (1 % 2))] -}


