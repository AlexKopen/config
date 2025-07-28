-- imports
import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Layout.ResizableTile
import XMonad.Actions.CycleWS
import Graphics.X11.ExtraTypes.XF86
import XMonad.Layout.CenteredIfSingle
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Actions.SpawnOn (spawnOn)
import XMonad.Layout.BoringWindows
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.WindowNavigation
import XMonad.Operations (setLayout)
import Control.Monad (liftM2)
import qualified Data.Map as M
import XMonad.Actions.MouseResize

-- colors and fonts
myTabConfig = def { fontName            = "xft:Mononoki Nerd Font:bold:size=9"
                  , activeColor         = "#292d3e"
                  , inactiveColor       = "#3f4042"
                  , activeBorderColor   = "#292d3e"
                  , inactiveBorderColor = "#282c34"
                  , activeTextColor     = "#ffffff"
                  , inactiveTextColor   = "#d0d0d0"
                  }

-- super & alt assignments
superMask = mod4Mask
altMask = mod1Mask

-- all layouts
myLayout = avoidStruts
           $ boringWindows
           $ centeredIfSingle 0.75 1
           $ addTabs shrinkText myTabConfig
           $ subLayout [] Simplest
           $ spacing 5
           $ (Tall 1 (3/100) (1/2) ||| fullscreenFull Simplest)

-- all workspaces
myWorkspaces :: [String]
myWorkspaces = ["1","2","3","4","5","6","7","8","9","10"]

-- enable dragging of floating windows
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w))
    ]

-- force guake to float
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Guake" --> doFloat
    , manageDocks
    ]

-- window merge
superControlMActions = do
    withFocused (sendMessage . MergeAll)
    withFocused (sendMessage . UnMerge)
    windows W.swapMaster

-- startup scripts
main = do
    spawn $ unlines
        [ "(killall -q polybar; sleep 2; polybar xmonad) &" -- polybar on top
        , "guake &" -- guake dropdown terminal
        , "nitrogen --restore &" -- nitrogen background
        , "xautolock -time 60 -locker \"i3lock-fancy\" &" -- i3lock after 1 hour
        , "xset s 3600 dpms &" -- turn off display after 1 hour
        , "xautolock -time 120 -locker \"systemctl suspend\" -detectsleep  &" -- sleeps after 2 hours
        , "pactl set-sink-volume @DEFAULT_SINK@ 100% &" -- set volume to 100%
        , "numlockx on &" -- enable numlock
        , "xinput set-prop \"$(xinput list --id-only 'Logitech G502 HERO Gaming Mouse')\" 'libinput Accel Speed' 1" -- set the mouse sensitivity
        , "xdg-mime default thunar.desktop inode/directory" -- set thunar to default file explorer
        ]

    -- hooks, key bindings, and visual configs
    xmonad $ docks $ ewmh def
        { manageHook = myManageHook <+> manageHook def
        , layoutHook = myLayout

        -- startup
        , startupHook = do
            spawnOn "10" "spotify"
            spawnOn "10" "sleep 2 && firefox mail.google.com web.whatsapp.com messages.google.com finance.google.com"
            windows $ W.greedyView "10"
        
        -- basic assignments
        , modMask = superMask
        , terminal = "alacritty"
        , borderWidth = 2
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#cd8b00"
        , workspaces = myWorkspaces
        , mouseBindings = myMouseBindings
        } 
        
        -- all key assignments
        `additionalKeys`
        ( [ ((superMask .|. shiftMask, xK_r), spawn "xmonad --recompile; xmonad --restart")
          -- xkill
          , ((superMask, xK_Escape), spawn $ "xkill")

          -- merging and tab navigation
          , ((superMask .|. controlMask, xK_m), superControlMActions)
          , ((superMask .|. controlMask, xK_period), onGroup W.focusUp')

          -- window movements
          , ((superMask, xK_j), focusDown)
          , ((superMask, xK_k), focusUp)
          , ((superMask .|. shiftMask, xK_j), windows W.swapDown)
          , ((superMask .|. shiftMask, xK_k), windows W.swapUp)
          , ((superMask .|. shiftMask, xK_m), windows W.swapMaster)
          , ((superMask, xK_t), withFocused $ windows . W.sink)

          -- utitilies in polybar
          , ((superMask, xK_p ), spawn $ "pavucontrol")
          , ((superMask, xK_v ), spawn $ "cd /opt/piavpn/bin && ./pia-client")

          -- passwords
          , ((superMask, xK_z ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS1 | xclip -selection clipboard")
          , ((superMask, xK_x ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS2 | xclip -selection clipboard")
          , ((superMask, xK_c ), spawn $ "cd $HOME/.xmonad && chmod +x pass.sh && . ./pass.sh && echo -n $PASS3 | xclip -selection clipboard")

          -- function keys
          , ((superMask, xK_F1), spawn $ "firefox" )
          , ((superMask, xK_F2), spawn $ "thunar" )
          , ((superMask, xK_F3), spawn $ "cd $HOME/.xmonad && chmod +x sleep.sh && . ./sleep.sh" )
          , ((superMask, xK_F4), spawn $ "cd $HOME/.xmonad && chmod +x lock.sh && . ./lock.sh" )
          , ((superMask, xK_F5), spawn $ "cd $HOME/.xmonad && chmod +x reboot.sh && . ./reboot.sh" )
          , ((superMask, xK_F6), spawn $ "cd $HOME/.xmonad && chmod +x shutdown.sh && . ./shutdown.sh" )
          , ((superMask, xK_F7), spawn $ "cd $HOME/.xmonad && chmod +x logout.sh && . ./logout.sh" )
          , ((superMask, xK_F8), spawn $ "cd $HOME; code ." )

          -- terminal
          , ((superMask, xK_Return), spawn "alacritty")

          -- audio controls
          , ((0, xF86XK_AudioPlay), spawn $ "playerctl --player=spotify play-pause")
          , ((0, xF86XK_AudioNext), spawn $ "playerctl --player=spotify next")
          , ((0, xF86XK_AudioPrev), spawn $ "playerctl --player=spotify previous")
          , ((0, xF86XK_AudioStop), spawn $ "playerctl --player=spotify stop")
          , ((0, xF86XK_AudioMute), spawn $ "pactl set-sink-mute @DEFAULT_SINK@ toggle")

          -- screenshots
          , ((0, xK_Print), spawn $ "maim -s $HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png")

          -- force kill
          , ((superMask, xK_q), kill)

          -- rofi + cheat menu
          , ((superMask, xK_d), spawn "rofi -show run")
          , ((superMask .|. altMask, xK_c), spawn "rofi -dmenu -i -p \"Cheatsheet\" -theme-str 'window { height: 600px; }' < \"$HOME/.xmonad/cheats.txt\"")

          -- layout switch (fullscreen with tabs vs normal) and layout reset
          , ((superMask, xK_space), sendMessage NextLayout)
          , ((superMask .|. shiftMask, xK_space), setLayout (Layout myLayout))

          -- workspace navigation and window resizing
          , ((controlMask .|. altMask, xK_Left), prevWS)
          , ((controlMask .|. altMask, xK_Right), nextWS)
          , ((controlMask .|. shiftMask, xK_h), sendMessage Shrink)
          , ((controlMask .|. shiftMask, xK_l), sendMessage Expand)
          ] ++

          -- workspace defintion
          [ ((m .|. superMask, k), windows $ f i)
            | (i, k) <- zip myWorkspaces ([xK_1 .. xK_9] ++ [xK_0])
            , (f, m) <- [(W.greedyView, 0), (liftM2 (.) W.greedyView W.shift, shiftMask)]
          ]
        )
