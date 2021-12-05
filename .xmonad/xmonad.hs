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
import XMonad.Hooks.ManageDocks (avoidStruts, docks, docksStartupHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, isDialog,  doFullFloat, doCenterFloat) 
import XMonad.Hooks.Place (placeHook, withGaps, smart)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops   -- required for xcomposite in obs to work

-- Actions
import XMonad.Actions.CycleWS
import XMonad.Actions.MouseResize
import XMonad.Actions.UpdatePointer

-- Layout modifiers
import XMonad.Layout.PerWorkspace (onWorkspace) 
import XMonad.Layout.Renamed (renamed, Rename(CutWordsLeft, Replace))
import XMonad.Layout.WorkspaceDir
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.Reflect (reflectVert, reflectHoriz, REFLECTX(..), REFLECTY(..))
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), Toggle(..), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, FULL, MIRROR, NOBORDERS))
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

-- New layouts
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Grid

-- Utilities
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig

-- Variable declarations
modKey = mod1Mask
myTerminal = "alacritty"
myTextEditor = "nvim"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False
myBrowser = "brave"
-- windowCount     = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

--Borders
myNormalBorderColor  = "#000"
myBorderWidth   = 1
myFocusedBorderColor = "#28bd68"
--"#45633d"

-- Commands
recompileCmd = "alacritty -e /bin/sh -c '/usr/bin/xmonad --recompile || read'"
restartCmd = "alacritty -e /bin/sh -c '(/usr/bin/xmonad --recompile && /usr/bin/xmonad --restart) || read'"
updateCmd = "alacritty -e /bin/sh -c '/usr/bin/yay -Suy && /home/juuso/.local/user/scripts/update-count'"
emojiCmd = "rofimoji -c --skin-tone neutral --max-recent 0" --"~/.local/user/scripts/emenu"

-- Wrappers to make it easier to call some functions. I'm a noob. Please dont hurt me

toggleGaps = do
    toggleWindowSpacingEnabled
    toggleScreenSpacingEnabled

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
hyper = "M4-M1-C-S-"
myKeys =
    [ 
        -- Monad control
        ("M-C-r", spawn recompileCmd),
        ("M-C-S-r", spawn restartCmd),
        ("M-C-S-q", io exitSuccess),
        (hyper ++ "s", spawn "systemctl suspend"),

        -- Core stuff
        (hyper ++ "u", spawn updateCmd),
        ("M-<Return>", spawn myTerminal),
        ("M-S-<Return>", spawn "dmenu_run"),
        ("M-S-q", kill),

        -- Navigation and window manipulation
        ("M-j", windows W.focusDown),                       -- Move focus down the stack
        ("M-S-j", windows W.swapDown),                      -- Move focused window down the stack
        ("M-k", windows W.focusUp),                         -- Move focus up the window stack
        ("M-S-k", windows W.swapUp),                        -- Move focused window up the stack
        ("M-m", windows W.focusMaster),                     -- Focus master area
        ("M-S-m", windows W.swapMaster),                    -- Swap focused window with the window at the master area
        ("M-u", sendMessage Shrink),                        -- Shrink the master area
        ("M-o", sendMessage Expand),                        -- Expand the master area
        ("M-+", sendMessage (IncMasterN 1)),                -- Increment the number of windows in the master area
        ("M--", sendMessage (IncMasterN (-1))),             -- Deincrement the number of windows in the master area

        -- Workspace and screeens
        ("M-l", nextWS),                                    -- Next workspace
        ("M-h", prevWS),                                    -- Previous workspace
        ("M-S-l", shiftToNext >> nextWS),                                    -- Next workspace
        ("M-S-h", shiftToPrev >> prevWS),                                    -- Next workspace
        ("M-<Tab>", nextScreen),                            -- Toggle screen (on 2 monitor systems)
        ("M-S-<Tab>", shiftNextScreen),                     -- Send selected window to next screen

        -- Layouts
        ("M-f", sendMessage $ Toggle FULL),                 -- Toggle selected window to fullscreen
        ("M-<Delete>", withFocused $ windows . W.sink),     -- Push floating window back into tiling mode
        ("M-<Backspace>", sendMessage $ NextLayout),        -- Switch to next layout algorithm
        ("M-g M-g", toggleGaps),                            -- Toggle window gaps
        ("M-g M-+", incScreenWindowSpacing 3),              -- Increase screen and window spacing by 3 pixels
        ("M-g M--", decScreenWindowSpacing 3),              -- Decrease screen and window spacing by 3 pixels
        ("M-g M-0", setScreenWindowSpacing 5),              -- Reset screen and window spacing to 5 pixels

        -- Fuynction keys
        ("M-<F1>", spawn myBrowser),                        -- Start browser
        ("M-<F12>", spawn "~/.local/user/scripts/setwp -r"),

        -- My own stuff
        ("M-S-e", spawn emojiCmd),                          -- Emoji selector
        ("M-S-p", spawn "sleep 0.2;scrot -s ~/Pictures/screenshots/$(date +%F_%T).png -e 'xclip -selection clipboard -t image/png < $f'"),

        -- Download shit
        ("M-w w", spawn "~/repos/suckless/dwm/patches/get")
    ]
    ++  -- M-[0..9] --> switch to workspace
        -- M-S-[0..9] --> move view to workspace
    [("M-" ++ modifier ++ key, windows $ function i) |
        (i, key) <- zip myWorkspaces (([1..9] ++ [0])>>= return.show),
        (function, modifier) <- [(W.greedyView, ""), (W.shift, "S-")]]

myMouseBindings (XConfig {XMonad.modMask = modKey}) = M.fromList $

    [ ((modKey, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    , ((modKey, button2), (\w -> focus w >> w W.sink
                                         >> windows W.shiftMaster))

    , ((modKey, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    -- scroll wheel (button4 and button5)
    ]


-- Workspaces
-- Clickable workspaces by DT :)
xmobarEscape = concatMap doubleLts
    where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) 
                $ ["I","II","III","IV","V","VI","VII","VIII","IX","X"]
            where
                clickable l = ["<action=xdotool key super+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                    (i, ws) <- zip ([1..9] ++ [0]) l,
                    let n = i ]

-- Layouts
winSpace = 5
scrSpace = 5
smarterSpacing = spacingRaw True (Border scrSpace scrSpace scrSpace scrSpace) True (Border winSpace winSpace winSpace winSpace) True

myLayoutHook =  mkToggle (NOBORDERS ?? FULL ?? EOT)
                $ myDefaultLayout
            where 
                myDefaultLayout =  tall ||| grid

tall = renamed [Replace "tall"]     $ avoidStruts $ smarterSpacing $ limitWindows 8 $ Tall 1 (3/100) (1/2)
grid = renamed [Replace "grid"]     $ avoidStruts $ smarterSpacing $ limitWindows 9 $ GridRatio (3/3)

-- Window rules be here
myManageHook = composeAll
    [
        isFullscreen --> doFloat,
        className =? "Gimp" --> doFloat,
        manageDocks
    ]

-- myEventHook = mempty

-- Autostart
myStartupHook = do
    spawnOnce "sh ~/.local/user/scripts/guinit"

main = do
    xmproc0 <- spawnPipe "xmobar -x 0 /home/juuso/.config/xmobar/xmobarrc"
    xmproc1 <- spawnPipe "xmobar -x 1 /home/juuso/.config/xmobar/xmobarrc"
    xmonad $ docks $ ewmh desktopConfig
        {   
            manageHook = myManageHook,
            logHook = dynamicLogWithPP xmobarPP
                {
                    ppOutput = \x -> hPutStrLn xmproc0 x >> hPutStrLn xmproc1 x,
                    ppCurrent = xmobarColor "#c3e88d" "" . wrap "[" "]",  -- Current workspace in xmobar
                    ppVisible = xmobarColor "#c3e88d" "",                 -- Visible but not current workspace
                    ppHidden = xmobarColor "#82AAFF" "" . wrap "*" "",    -- Hidden workspaces in xmobar
                    ppHiddenNoWindows = xmobarColor "#F07178" "",         -- Hidden workspaces (no windows)
                    ppTitle = mempty, --xmobarColor "#d0d0d0" "" . shorten 30,      -- Title of active window in xmobar
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
            handleEventHook    = fullscreenEventHook,
            startupHook        = myStartupHook
        } `additionalKeysP` myKeys
