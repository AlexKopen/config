import System.IO
import System.Exit

import XMonad hiding((|||))
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers(doFullFloat, doCenterFloat, isFullscreen, isDialog)
import XMonad.Config.Desktop
import XMonad.Config.Azerty
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Actions.CycleWS
import XMonad.Hooks.UrgencyHook
import qualified Codec.Binary.UTF8.String as UTF8

import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.IndependentScreens
import XMonad.Layout.LayoutCombinators

import XMonad.Layout.CenteredMaster(centerMaster)

import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import qualified Data.ByteString as B
import Control.Monad (liftM2)

myStartupHook = do
    spawn "$HOME/.xmonad/scripts/autostart.sh"
    setWMName "LG3D"

-- colors
normBord = "#4c566a"
focdBord = "#5e81ac"
fore     = "#DEE3E0"
back     = "#282c34"
winType  = "#c678dd"

myModMask = mod4Mask
encodeCChar = map fromIntegral . B.unpack
myFocusFollowsMouse = True
myBorderWidth = 2
myWorkspaces    = ["1","2","3","4","5","6","7","8","9","10"]

myBaseConfig = desktopConfig

-- window manipulations
myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    ]
    where
    myCFloats = ["Downloads", "Save As...", "Guake"]
    myTFloats = ["Calculator", "Calendar"]
    myRFloats = []
    myIgnores = ["desktop_window"]

myLayout = spacingRaw True (Border 0 5 5 5) True (Border 5 5 5 5) True $ avoidStruts $ tiled ||| ThreeColMid 1 (3/100) (1/2)
    where
        tiled = Tall nmaster delta tiled_ratio
        nmaster = 1
        delta = 3/100
        tiled_ratio = 1/2

myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    ]

-- keys config

--mod4Mask= super key
--mod1Mask= alt key
--controlMask= ctrl key
--shiftMask= shift key

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
  ----------------------------------------------------------------------
  -- USER CORE

 [  ((modMask, xK_Return), spawn $ "alacritty" )
  , ((modMask, xK_q), kill ) 
  , ((modMask, xK_Escape), spawn $ "xkill" )
  , ((modMask, xK_d ), spawn $ "rofi -show run")
  , ((modMask, xK_i ), spawn $ "gnome-disks")
  , ((modMask, xK_l ), spawn $ "lxappearance")
  , ((0, xK_Print), spawn $ "killall gnome-screenshot; gnome-screenshot -a")

  -- USER APPS

  , ((modMask, xK_F1), spawn $ "brave" )
  , ((modMask, xK_F2), spawn $ "spotify" )
  , ((modMask, xK_F3), spawn $ "phpstorm" )
  , ((modMask, xK_F4), spawn $ "nautilus" )

  , ((modMask, xK_F5), spawn $ "cd ~; subl . ~/.zshrc ~/.xmonad/scripts/autostart.sh  ~/.config/polybar/config ~/.xmonad/xmonad.errors ~/.xmonad/xmonad.hs" )
  , ((modMask, xK_F6), spawn $ "gnome-calendar" )
  , ((modMask, xK_F7), spawn $ "gnome-calculator" )
  , ((modMask, xK_F8), spawn $ "gsettings reset org.gnome.ControlCenter last-panel; gnome-control-center" )

  , ((modMask, xK_F9), spawn $ "systemctl poweroff" )
  , ((modMask, xK_F10), spawn $ "systemctl suspend" )
  , ((modMask, xK_F11), spawn $ "loginctl terminate-user $(whoami)" )
  , ((modMask, xK_F12), spawn $ "guake-toggle" )

  --MULTIMEDIA KEYS

  -- Volume
  , ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle")
  , ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-")
  , ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+")

  -- Track seeking
  , ((0, xF86XK_AudioPlay), spawn $ "playerctl --player=spotify play-pause")
  , ((0, xF86XK_AudioNext), spawn $ "playerctl --player=spotify next")
  , ((0, xF86XK_AudioPrev), spawn $ "playerctl --player=spotify previous")
  , ((0, xF86XK_AudioStop), spawn $ "playerctl --player=spotify stop")

  --------------------------------------------------------------------
  --  XMONAD CORE

  -- Recompile and restart
  , ((modMask .|. shiftMask , xK_r ), spawn $ "xmonad --recompile && xmonad --restart")

  -- Cycle through the available layout algorithms.
  , ((modMask, xK_space), sendMessage NextLayout)

  --  Reset the layouts on the current workspace to default.
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

  -- Navigate to previous workspace
  , ((controlMask .|. mod1Mask , xK_Left ), prevWS)

  -- Navigate to next workspace
  , ((controlMask .|. mod1Mask , xK_Right ), nextWS)

  -- Move focus to the next window.
  , ((modMask, xK_j), windows W.focusDown)

  -- Move focus to the previous window.
  , ((modMask, xK_k), windows W.focusUp  )

  -- Swap focus with the master window.
  , ((modMask .|. shiftMask, xK_m), windows W.swapMaster)

  -- Focus on the master window.
  , ((modMask, xK_m), windows W.focusMaster)

  -- Swap the focused window with the next window.
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown)

  -- Swap the focused window with the previous window.
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp)

  -- Shrink the master area.
  , ((controlMask .|. shiftMask , xK_h), sendMessage Shrink)

  -- Expand the master area.
  , ((controlMask .|. shiftMask , xK_l), sendMessage Expand)

  -- Push window back into tiling.
  , ((modMask .|. shiftMask , xK_t), withFocused $ windows . W.sink)

  -- Increment the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Left), sendMessage (IncMasterN 1))

  -- Decrement the number of windows in the master area.
  , ((controlMask .|. modMask, xK_Right), sendMessage (IncMasterN (-1)))

  ]
  ++

  -- mod-[1..9], Switch to workspace N
  -- mod-shift-[1..9], Move client to workspace N
  [((m .|. modMask, k), windows $ f i)

  --Keyboard layouts
   | (i, k) <- zip (XMonad.workspaces conf) [xK_1,xK_2,xK_3,xK_4,xK_5,xK_6,xK_7,xK_8,xK_9,xK_0]
      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)
      , (\i -> W.greedyView i . W.shift i, shiftMask)]]


main :: IO ()
main = do

    xmonad . ewmh $
            myBaseConfig
                {startupHook = myStartupHook
, layoutHook = gaps [(U,35), (D,5), (R,5), (L,5)] $ myLayout ||| layoutHook myBaseConfig
, manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig
, modMask = myModMask
, borderWidth = myBorderWidth
, handleEventHook    = handleEventHook myBaseConfig <+> fullscreenEventHook
, focusFollowsMouse = myFocusFollowsMouse
, workspaces = myWorkspaces
, focusedBorderColor = focdBord
, normalBorderColor = normBord
, keys = myKeys
, mouseBindings = myMouseBindings
}
