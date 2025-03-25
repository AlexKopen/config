import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Layout.ResizableTile
import XMonad.Actions.CycleWS
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.Renamed
import XMonad.Actions.MouseResize
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import Control.Monad (liftM2)
import XMonad.Operations (setLayout)
import qualified Data.Map as M
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.Simplest
import XMonad.Actions.CycleWindows
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Simplest
import XMonad.Actions.SpawnOn (spawnOn)

myTabConfig = def { fontName            = "xft:Mononoki Nerd Font:bold:size=9"
                  , activeColor         = "#292d3e"
                  , inactiveColor       = "#3f4042"
                  , activeBorderColor   = "#292d3e"
                  , inactiveBorderColor = "#282c34"
                  , activeTextColor     = "#ffffff"
                  , inactiveTextColor   = "#d0d0d0"
                  }


superMask = mod4Mask
altMask = mod1Mask

myLayouts = Tall 1 (3/100) (1/2) ||| fullscreenFull Simplest

myLayout = avoidStruts $ boringWindows $ addTabs shrinkText myTabConfig $ subLayout [] (Simplest) $ spacing 5 myLayouts


-- Enable dragging of floating windows
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w))
    ]


myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Guake" --> doFloat
    , manageDocks
    ]

superControlMActions = do
    withFocused (sendMessage . MergeAll)
    withFocused (sendMessage . UnMerge)
    windows W.swapMaster

main = do
    spawn "(killall -q polybar; sleep 2; polybar mainbar-xmonad --config=~/.config/polybar/config.ini) & guake & nitrogen --restore & xautolock -time 60 -locker \"i3lock-fancy\" & (xset dpms 3600 3600 3600 & xset s 3600 & xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -s 60) & pactl set-sink-volume @DEFAULT_SINK@ 100% & systemctl start jellyfin"
    xmonad $ docks $ ewmh def
        { manageHook = myManageHook <+> manageHook def
        , layoutHook = myLayout
        , startupHook = do
            spawnOn "10" "spotify"
            spawnOn "10" "sleep 2 && firefox mail.google.com web.whatsapp.com messages.google.com finance.google.com"
            windows $ W.greedyView "10"
        , modMask = superMask
        , terminal = "alacritty"
        , borderWidth = 2
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#cd8b00"
        , workspaces = ["1","2","3","4","5","6","7","8","9","10"]
        , mouseBindings = myMouseBindings
        } `additionalKeys`
        ( [ 
          (
            
            (superMask .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
            , ((superMask, xK_Escape), spawn $ "xkill" )


          -- Window tabs
          , ((superMask .|. controlMask, xK_m), superControlMActions)
          , ((superMask .|. controlMask, xK_period), onGroup W.focusUp')

            
          , ((superMask, xK_j), focusDown)
          , ((superMask, xK_k), focusUp)
          , ((superMask .|. shiftMask, xK_j), windows W.swapDown)
          , ((superMask .|. shiftMask, xK_k), windows W.swapUp)
          , ((superMask .|. shiftMask, xK_m), windows W.swapMaster)

  
          -- -- Keybinding to toggle float/tiled mode
          , ((superMask, xK_t), withFocused $ windows . W.sink)

          -- PROGRAMS
          , ((superMask, xK_p ), spawn $ "pavucontrol")
          , ((superMask, xK_v ), spawn $ "cd /opt/piavpn/bin && ./pia-client")
          , ((superMask, xK_z ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS1 | xclip -selection clipboard")
          , ((superMask, xK_x ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS2 | xclip -selection clipboard")
          , ((superMask, xK_c ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS3 | xclip -selection clipboard")
    
          
          -- FUNCTION KEYS

          , ((superMask, xK_F1), spawn $ "firefox" )
          , ((superMask, xK_F2), spawn $ "spotify" )
          , ((superMask, xK_F3), spawn $ "webstorm" )
          , ((superMask, xK_F4), spawn $ "code" )

          , ((superMask, xK_F5), spawn $ "goland" )
          , ((superMask, xK_F6), spawn $ "thunar" )
          , ((superMask, xK_F7), spawn $ "i3lock-fancy" )
          , ((superMask, xK_F8), spawn $ "reboot" )

          , ((superMask, xK_F9), spawn $ "systemctl poweroff" )
          , ((superMask, xK_F10), spawn $ "systemctl suspend" )
          , ((superMask, xK_F11), spawn $ "loginctl terminate-user $USER" )
          , ((superMask, xK_F12), spawn $ "guake-toggle" )

          -- Utilities
          , ((superMask, xK_Return), spawn "alacritty")

          , ((0, xF86XK_AudioPlay), spawn $ "playerctl --player=spotify play-pause")
          , ((0, xF86XK_AudioNext), spawn $ "playerctl --player=spotify next")
          , ((0, xF86XK_AudioPrev), spawn $ "playerctl --player=spotify previous")
          , ((0, xF86XK_AudioStop), spawn $ "playerctl --player=spotify stop")
          

          -- Volume
          , ((0, xF86XK_AudioMute), spawn $ "pactl set-sink-mute @DEFAULT_SINK@ toggle")
          , ((0, xF86XK_AudioLowerVolume), spawn $ "pactl set-sink-volume @DEFAULT_SINK@ -5%")
          , ((0, xF86XK_AudioRaiseVolume), spawn $ "pactl set-sink-volume @DEFAULT_SINK@ +5%")

          , ((0, xK_Print), spawn $ "maim -s ~/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png")

          , ((superMask, xK_q), kill)
          , ((superMask, xK_d), spawn "rofi -show run")
          , ((superMask, xK_space), sendMessage NextLayout)
          , ((superMask .|. shiftMask, xK_space), setLayout $ Layout myLayout)
          , ((controlMask .|. altMask, xK_Left), prevWS)
          , ((controlMask .|. altMask, xK_Right), nextWS)
          , ((controlMask .|. shiftMask, xK_h), sendMessage Shrink)
          , ((controlMask .|. shiftMask, xK_l), sendMessage Expand)
          ] ++
          [((m .|. superMask, k), windows $ f i)
            | (i, k) <- zip (workspaces def) ([xK_1 .. xK_9] ++ [xK_0])
            , (f, m) <- [(W.greedyView, 0), (liftM2 (.) W.greedyView W.shift, shiftMask)]]
        ++
          [((superMask, xK_0), windows $ W.greedyView "10")
          , ((superMask .|. shiftMask, xK_0), windows $ W.shift "10")]
        )
