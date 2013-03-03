import XMonad hiding ( (|||) )
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Actions.SpawnOn
import XMonad.Actions.CycleWS (toggleWS, nextWS, prevWS, shiftToNext, shiftToPrev )
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Layout.LayoutCombinators ((|||), JumpToLayout(..))
import XMonad.StackSet as W (focusUp, focusDown, swapDown, swapUp, shift, sink)
import System.IO
import XMonad.Layout.NoBorders     -- smart borders on solo clients
import XMonad.Layout.Fullscreen (fullscreenFull)

myWorkspaces = ["α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ" ]
myTerm = "terminator"



myStartup :: X ()
myStartup = do
        spawn "~/.xmonad/autostart.sh"


mylayout = avoidStruts (tall ||| Mirror tall ||| Full) ||| fullscreenFull Full
        where
            tall = Tall 1 (3/100) (1/2)

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
myManageHook = composeAll
        [ className =? "Chromium" --> doShift "γ"
        , className =? "Gnome-mplayer" --> doFloat
        , isFullscreen --> (doF W.focusDown <+> doFullFloat) -- flash player fullscreen mode
        ]



bindKeys =
    	[ ("M-S-z", spawn "cb-exit") -- Crunachbang Linux "Exit" utilite 
        , ("C-<Print>", spawn "sleep 0.2; scrot -s '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f ~/images/ &amp; viewnior ~/images/$f'")
        , ("<Print>", spawn "scrot '%Y-%m-%d--%s_$wx$h_scrot.png' -e 'mv $f ~/images/ &amp; viewnior ~/images/$f'")
        , ("M-<Return>", spawn myTerm)
        , ("M-k",         windows W.focusUp)
        , ("M-j",         windows W.focusDown)
        , ("M-S-k",       windows W.swapUp)
        , ("M-S-j",       windows W.swapDown)
        , ("M1-<Tab>"    , toggleWS) -- toggle last workspace (super-tab)
        , ("M-<Right>"  , nextWS) -- go to next workspace
        , ("M-<Left>"   , prevWS) -- go to prev workspace
        , ("M-S-<Right>", shiftToNext) -- move client to next workspace
        , ("M-S-<Left>" , shiftToPrev) -- move client to prev workspace
        , ("M-w", sendMessage $ JumpToLayout "Tall")
        , ("M-e", sendMessage $ JumpToLayout "Mirror Tall")
        , ("M-r", sendMessage $ JumpToLayout "Full")   
        ]
        



unbindKeys = 
        [ ("M-S-<Return>")
        , ("M-m")
        ]



main = do
        xmproc <- spawnPipe "~/.cabal/bin/xmobar ~/.xmonad/xmobarrc"
        xmonad $ defaults
            { manageHook = manageDocks <+> myManageHook
             , logHook = dynamicLogWithPP $ xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppCurrent = xmobarColor "#ee9a00" "" . wrap "[" "]"
--                        , ppHiddenNoWindows = xmobarColor "#777777" "" 
                        , ppTitle = xmobarColor "lightgreen" "" . shorten 80
                        , ppSep = " | "
                        }
             } `additionalKeysP` bindKeys `removeKeysP` unbindKeys
        


defaults = defaultConfig {
          terminal = myTerm
        , workspaces  = myWorkspaces
        , handleEventHook = fullscreenEventHook
        , layoutHook = mylayout
        , normalBorderColor = "#D3D7CF"
        , focusedBorderColor = "#00F353"
        , borderWidth = 1
        , modMask = mod4Mask
        , startupHook = myStartup
        }

