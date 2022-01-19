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
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks


import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig 
import XMonad.Util.NamedScratchpad
--import XMonad.Hooks.EwmhDesktops

myLayoutHook =  smartBorders $ gaps [(U,20) , (D,20) , (L,20) , (R,20)] $ avoidStruts (ThreeCol 1 (3/100) (1/2)  |||  Full  ||| centerMaster Grid  )

myTerminal = "urxvt"
myModMask  = mod4Mask
myNormalBorderColor =  "#000000" --"#F7F7F7"
myFocusedBorderColor =  "#334257" --"#EEEEEE"
myBorderWidth = 3 
myManageHook = manageSpawn <+> manageHook def <+> namedScratchpadManageHook myScratchPads <+> manageDocks <+> (composeAll . concat  $
        [ [(className =? x <||> title =? x <||> resource =? x) --> doShift "2" | x <- my2Shifts]
        ])
        where
        my2Shifts = ["brave-browser"]




myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "ecx" spawnECX findECX manageECX 
                ]
  where
    spawnTerm  = "~/urxvtc.sh -name scratchpad"
    findTerm   = resource =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect x y w h
               where
                 h = 0.9
                 w = 0.9
                 y = (1.025 - h)/2
                 x = (1 - w)/2
               
    spawnECX = "./ecx.sh"
    findECX  = title =? "ecx"
    manageECX = customFloating $ W.RationalRect x y w h
               where
                 h = 0.98
                 w = 0.98
                 y = (1.025 - h) / 2
                 x = (1 - w) / 2



myStartupHook = do
        --      spawnAndDo (doRectFloat (W.RationalRect 0.1 0.1 0.4 0.8)) "emacs"
        --      spawnAndDo (doShift "1") "emacs"
        --      spawnAndDo (doShift "1") "urxvt"
        --      spawnAndDo (doRectFloat (W.RationalRect 0.1 0.1 0.4 0.8) <+>doShift "1") "brave"

                spawnAndDo (doShift "2") "brave"    
        --      spawnAndDo (doRectFloat (W.RationalRect 0.55 0.1 0.4 0.8)) "urxvt"
                spawnOnce "emacs --daemon=xmonad"
                spawnOnce " urxvtd -q -o -f "
                spawnOnce "picom -b"
                spawnOnce "xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg"

 


myKeys :: [(String, X ())]
myKeys = 
        [ ("C-M4-r", spawn "urxvtc -hold -e xmonad --recompile")       -- Recompiles xmonad
        , ("C-M4-t", namedScratchpadAction myScratchPads "terminal")
        , ("C-M4-s", namedScratchpadAction myScratchPads "ecx")
        , ("C-M4-m", sendMessage $ ToggleGaps)     
        , ("C-M4-h", sendMessage ToggleStruts)
        ]



main :: IO ()
main = do
xmproc <- spawnPipe "xmobar -x 0 ~/.xmobarrc"
xmonad $ docks $ def
      {terminal            = myTerminal
  {-  ,  focusFollowsMouse  = myFocusFollowsMouse
      ,  clickJustFocuses   = myClickJustFocuses      -}
      ,  borderWidth        = myBorderWidth            
      ,  modMask            = myModMask
  --  ,  workspaces         = myWorkspaces
      ,  normalBorderColor  = myNormalBorderColor
      ,  focusedBorderColor = myFocusedBorderColor    

      -- key bindings
  --  , keys               = myKeys
  --  , mouseBindings      = myMouseBindings           

      -- hooks, layouts
      , layoutHook         = smartSpacingWithEdge 20 $ myLayoutHook
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