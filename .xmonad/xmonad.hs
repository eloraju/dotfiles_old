
-- Imports

-- Base stuff
import XMonad
import XMonad.Config.Desktop
import Data.Monoid
import System.Exit (exitSuccess)
import qualified Data.Map        as M
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, defaultPP, wrap, pad, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks (avoidStruts, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

-- Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize



-- Layout modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing (spacing) 
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))


-- New layouts
import XMonad.Layout.SimplestFloat


-- Utilities
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig


-- Variable declarations
modKey       = mod4Mask
myTerminal = "alacritty"
myTextEditor = "nvim"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False
myBrowser = "brave"
-- windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Workspaces
myWorkspaces    = ["0","1","2","3","4","5","6","7","8","9"]
numbKeys        = [xK_0..xK_9]

--Borders
myNormalBorderColor  = "#000000"
myBorderWidth   = 2
myFocusedBorderColor = "#fff"


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys =
    [ 
        -- Monad control
        ("M-C-r", spawn "xmonad --recompile"),
        ("M-C-S-r", spawn "xmonad --recompile; xmonad --restart"),
        ("M-C-S-q", io exitSuccess),
        ("M-<F12>", setLayout myLayoutHook),

        -- Core stuff
        ("M-<Return>", spawn myTerminal),
        ("M-S-<Return>", spawn "dmenu_run"),
        ("M-S-q", kill),
        ("M-S-<Tab>", sendMessage NextLayout),              -- Rotate through the available layout algorithms

        -- Navigation and window manipulation
        ("M-j", windows W.focusDown),                       -- Move focus down the stack
        ("M-S-j", windows W.swapDown),                      -- Move focused window down the stack
        ("M-k", windows W.focusUp),                         -- Move focus up the window stack
        ("M-S-k", windows W.swapUp),                        -- Move focused window up the stack
        ("M-m", windows W.focusMaster),                     -- Focus master area
        ("M-S-m", windows W.swapMaster),                    -- Swap focused window with the window at the master area
        ("M-u", sendMessage Shrink),                        -- Shrink the master area
        ("M-o", sendMessage Expand),                        -- Expand the master area
        ("M-<Delete>", withFocused $ windows . W.sink),            -- Push window back into tiling
        ("M-+", sendMessage (IncMasterN 1)),                -- Increment the number of windows in the master area
        ("M--", sendMessage (IncMasterN (-1))),             -- Deincrement the number of windows in the master area

        -- Workspace and screeens
        ("M-l", nextWS),                                    -- Next workspace
        ("M-h", prevWS),                                    -- Previous workspace
        ("M-<Tab>", nextScreen),                            -- Toggle screen (on 2 monitor systems)

        -- My own stuff
        ("M-S-e", spawn "~/bin/emenu"),                     -- Emoji selector
        ("M-<F1>", spawn myBrowser),                        -- Start browser
        ("M-S-p", spawn "sleep 0.2;scrot -s ~/Pictures/screenshots/$(date +%F_%T).png -e 'xclip -selection clipboard -t image/png < $f'")
    ]
    ++  -- M-[0..9] --> switch to workspace
        -- M-S-[0..9] --> move view to workspace
    [("M-" ++ modifier ++ key, windows $ function i) |
        (i, key) <- zip myWorkspaces ([0..9] >>= return.show),
        (function, modifier) <- [(W.greedyView, ""), (W.shift, "S-")]]

myMouseBindings (XConfig {XMonad.modMask = modKey}) = M.fromList $

    [ ((modKey, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((modKey, button2), (\w -> focus w >> windows W.shiftMaster))

    , ((modKey, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

myLayoutHook = avoidStruts $ myDefaultLayout
             where 
                 myDefaultLayout = tall ||| Full

tall = renamed [Replace "tall"]     $ limitWindows 8 $ spacing 3 $ Tall 1 (3/100) (1/2) 

-- Window rules be here
myManageHook = mempty

myEventHook = mempty

-- Autostart
myStartupHook = do
    spawnOnce "sh ~/bin/guinit"

main = do
    xmproc0 <- spawnPipe "xmobar -x 0 /home/juuso/.config/xmobar/xmobarrc"
    xmproc1 <- spawnPipe "xmobar -x 1 /home/juuso/.config/xmobar/xmobarrc"
    xmonad $ ewmh desktopConfig
        {   
            manageHook = myManageHook <+> manageHook desktopConfig <+> manageDocks,
            logHook = dynamicLogWithPP xmobarPP
                {
                    ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x,
                    ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]",  -- Current workspace in xmobar
                    ppVisible = xmobarColor "#c3e88d" "",                 -- Visible but not current workspace
                    ppHidden = xmobarColor "#82AAFF" "" . wrap "*" "",    -- Hidden workspaces in xmobar
                    ppHiddenNoWindows = xmobarColor "#F07178" "",         -- Hidden workspaces (no windows)
                    ppTitle = xmobarColor "#d0d0d0" "" . shorten 30,      -- Title of active window in xmobar
                    ppSep =  "<fc=#666666> | </fc>",                      -- Separators in xmobar
                    ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!",   -- Urgent workspace
                    ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                },

            -- simple stuff
            modMask            = modKey,
            terminal           = myTerminal,
            focusFollowsMouse  = myFocusFollowsMouse,
            clickJustFocuses   = myClickJustFocuses,
            borderWidth        = myBorderWidth,
            workspaces         = myWorkspaces,
            normalBorderColor  = myNormalBorderColor,
            focusedBorderColor = myFocusedBorderColor,
     
            -- bindings
            mouseBindings      = myMouseBindings,
      
            -- hooks, layouts
            layoutHook         = myLayoutHook,
            handleEventHook    = myEventHook,
            startupHook        = myStartupHook
        } `additionalKeysP` myKeys
