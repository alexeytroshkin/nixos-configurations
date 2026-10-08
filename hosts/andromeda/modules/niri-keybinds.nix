{ ... }:
{
  # Migrated from Andromeda's existing DMS bindings, including laptop media keys.
  programs.niri.settings.binds = {
    "Mod+D" = {
      repeat = false;
      action.toggle-overview = [ ];
    };
    "Mod+Tab" = {
      repeat = false;
      action.toggle-overview = [ ];
    };
    "Mod+Shift+Slash" = {
      action.show-hotkey-overlay = [ ];
    };
    "Mod+T" = {
      hotkey-overlay.title = "Open Terminal";
      action.spawn = [ "ghostty" ];
    };
    "Mod+Space" = {
      hotkey-overlay.title = "Application Launcher";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "spotlight"
        "toggle"
      ];
    };
    "Mod+V" = {
      hotkey-overlay.title = "Clipboard Manager";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "clipboard"
        "toggle"
      ];
    };
    "Mod+M" = {
      hotkey-overlay.title = "Task Manager";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "processlist"
        "focusOrToggle"
      ];
    };
    "Super+X" = {
      hotkey-overlay.title = "Power Menu: Toggle";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "powermenu"
        "toggle"
      ];
    };
    "Mod+Comma" = {
      hotkey-overlay.title = "Settings";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "settings"
        "focusOrToggle"
      ];
    };
    "Mod+Y" = {
      hotkey-overlay.title = "Browse Wallpapers";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "dankdash"
        "wallpaper"
      ];
    };
    "Mod+N" = {
      hotkey-overlay.title = "Notification Center";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "notifications"
        "toggle"
      ];
    };
    "Mod+Shift+N" = {
      hotkey-overlay.title = "Notepad";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "notepad"
        "toggle"
      ];
    };
    "Mod+Alt+L" = {
      hotkey-overlay.title = "Lock Screen";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "lock"
        "lock"
      ];
    };
    "Mod+Shift+E" = {
      action.quit = [ ];
    };
    "Ctrl+Alt+Delete" = {
      hotkey-overlay.title = "Task Manager";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "processlist"
        "focusOrToggle"
      ];
    };
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "increment"
        "3"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "decrement"
        "3"
      ];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "mute"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "audio"
        "micmute"
      ];
    };
    "XF86AudioPause" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "playPause"
      ];
    };
    "XF86AudioPlay" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "playPause"
      ];
    };
    "XF86AudioPrev" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "previous"
      ];
    };
    "XF86AudioNext" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "next"
      ];
    };
    "Ctrl+XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "increment"
        "3"
      ];
    };
    "Ctrl+XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "mpris"
        "decrement"
        "3"
      ];
    };
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "increment"
        "5"
        ""
      ];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "brightness"
        "decrement"
        "5"
        ""
      ];
    };
    "Mod+Q" = {
      repeat = false;
      action.close-window = [ ];
    };
    "Mod+F" = {
      action.maximize-column = [ ];
    };
    "Mod+Shift+F" = {
      action.fullscreen-window = [ ];
    };
    "Mod+Shift+T" = {
      action.toggle-window-floating = [ ];
    };
    "Mod+Shift+V" = {
      action.switch-focus-between-floating-and-tiling = [ ];
    };
    "Mod+W" = {
      action.toggle-column-tabbed-display = [ ];
    };
    "Mod+Shift+W" = {
      hotkey-overlay.title = "Create window rule";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "window-rules"
        "toggle"
      ];
    };
    "Mod+Left" = {
      action.focus-column-left = [ ];
    };
    "Mod+Down" = {
      action.focus-window-down = [ ];
    };
    "Mod+Up" = {
      action.focus-window-up = [ ];
    };
    "Mod+Right" = {
      action.focus-column-right = [ ];
    };
    "Mod+H" = {
      action.focus-column-left = [ ];
    };
    "Mod+J" = {
      action.focus-window-down = [ ];
    };
    "Mod+K" = {
      action.focus-window-up = [ ];
    };
    "Mod+L" = {
      action.focus-column-right = [ ];
    };
    "Mod+Shift+Left" = {
      action.move-column-left = [ ];
    };
    "Mod+Shift+Down" = {
      action.move-window-down = [ ];
    };
    "Mod+Shift+Up" = {
      action.move-window-up = [ ];
    };
    "Mod+Shift+Right" = {
      action.move-column-right = [ ];
    };
    "Mod+Shift+H" = {
      action.move-column-left = [ ];
    };
    "Mod+Shift+J" = {
      action.move-window-down = [ ];
    };
    "Mod+Shift+K" = {
      action.move-window-up = [ ];
    };
    "Mod+Shift+L" = {
      action.move-column-right = [ ];
    };
    "Mod+Home" = {
      action.focus-column-first = [ ];
    };
    "Mod+End" = {
      action.focus-column-last = [ ];
    };
    "Mod+Ctrl+Home" = {
      action.move-column-to-first = [ ];
    };
    "Mod+Ctrl+End" = {
      action.move-column-to-last = [ ];
    };
    "Mod+Ctrl+Left" = {
      action.focus-monitor-left = [ ];
    };
    "Mod+Ctrl+Right" = {
      action.focus-monitor-right = [ ];
    };
    "Mod+Ctrl+H" = {
      action.focus-monitor-left = [ ];
    };
    "Mod+Ctrl+J" = {
      action.focus-monitor-down = [ ];
    };
    "Mod+Ctrl+K" = {
      action.focus-monitor-up = [ ];
    };
    "Mod+Ctrl+L" = {
      action.focus-monitor-right = [ ];
    };
    "Mod+Shift+Ctrl+Left" = {
      action.move-column-to-monitor-left = [ ];
    };
    "Mod+Shift+Ctrl+Down" = {
      action.move-column-to-monitor-down = [ ];
    };
    "Mod+Shift+Ctrl+Up" = {
      action.move-column-to-monitor-up = [ ];
    };
    "Mod+Shift+Ctrl+Right" = {
      action.move-column-to-monitor-right = [ ];
    };
    "Mod+Shift+Ctrl+H" = {
      action.move-column-to-monitor-left = [ ];
    };
    "Mod+Shift+Ctrl+J" = {
      action.move-column-to-monitor-down = [ ];
    };
    "Mod+Shift+Ctrl+K" = {
      action.move-column-to-monitor-up = [ ];
    };
    "Mod+Shift+Ctrl+L" = {
      action.move-column-to-monitor-right = [ ];
    };
    "Mod+Page_Down" = {
      action.focus-workspace-down = [ ];
    };
    "Mod+Page_Up" = {
      action.focus-workspace-up = [ ];
    };
    "Mod+U" = {
      action.focus-workspace-down = [ ];
    };
    "Mod+I" = {
      action.focus-workspace-up = [ ];
    };
    "Mod+Ctrl+Down" = {
      action.move-column-to-workspace-down = [ ];
    };
    "Mod+Ctrl+Up" = {
      action.move-column-to-workspace-up = [ ];
    };
    "Mod+Ctrl+U" = {
      action.move-column-to-workspace-down = [ ];
    };
    "Mod+Ctrl+I" = {
      action.move-column-to-workspace-up = [ ];
    };
    "Ctrl+Shift+R" = {
      hotkey-overlay.title = "Rename Workspace";
      action.spawn = [
        "dms"
        "ipc"
        "call"
        "workspace-rename"
        "open"
      ];
    };
    "Mod+Shift+Page_Down" = {
      action.move-workspace-down = [ ];
    };
    "Mod+Shift+Page_Up" = {
      action.move-workspace-up = [ ];
    };
    "Mod+Shift+U" = {
      action.move-workspace-down = [ ];
    };
    "Mod+Shift+I" = {
      action.move-workspace-up = [ ];
    };
    "Mod+WheelScrollDown" = {
      cooldown-ms = 150;
      action.focus-workspace-down = [ ];
    };
    "Mod+WheelScrollUp" = {
      cooldown-ms = 150;
      action.focus-workspace-up = [ ];
    };
    "Mod+Ctrl+WheelScrollDown" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-down = [ ];
    };
    "Mod+Ctrl+WheelScrollUp" = {
      cooldown-ms = 150;
      action.move-column-to-workspace-up = [ ];
    };
    "Mod+WheelScrollRight" = {
      action.focus-column-right = [ ];
    };
    "Mod+WheelScrollLeft" = {
      action.focus-column-left = [ ];
    };
    "Mod+Ctrl+WheelScrollRight" = {
      action.move-column-right = [ ];
    };
    "Mod+Ctrl+WheelScrollLeft" = {
      action.move-column-left = [ ];
    };
    "Mod+Shift+WheelScrollDown" = {
      action.focus-column-right = [ ];
    };
    "Mod+Shift+WheelScrollUp" = {
      action.focus-column-left = [ ];
    };
    "Mod+Ctrl+Shift+WheelScrollDown" = {
      action.move-column-right = [ ];
    };
    "Mod+Ctrl+Shift+WheelScrollUp" = {
      action.move-column-left = [ ];
    };
    "Mod+1" = {
      action.focus-workspace = [ 1 ];
    };
    "Mod+2" = {
      action.focus-workspace = [ 2 ];
    };
    "Mod+3" = {
      action.focus-workspace = [ 3 ];
    };
    "Mod+4" = {
      action.focus-workspace = [ 4 ];
    };
    "Mod+5" = {
      action.focus-workspace = [ 5 ];
    };
    "Mod+6" = {
      action.focus-workspace = [ 6 ];
    };
    "Mod+7" = {
      action.focus-workspace = [ 7 ];
    };
    "Mod+8" = {
      action.focus-workspace = [ 8 ];
    };
    "Mod+9" = {
      action.focus-workspace = [ 9 ];
    };
    "Mod+Shift+1" = {
      action.move-column-to-workspace = [ 1 ];
    };
    "Mod+Shift+2" = {
      action.move-column-to-workspace = [ 2 ];
    };
    "Mod+Shift+3" = {
      action.move-column-to-workspace = [ 3 ];
    };
    "Mod+Shift+4" = {
      action.move-column-to-workspace = [ 4 ];
    };
    "Mod+Shift+5" = {
      action.move-column-to-workspace = [ 5 ];
    };
    "Mod+Shift+6" = {
      action.move-column-to-workspace = [ 6 ];
    };
    "Mod+Shift+7" = {
      action.move-column-to-workspace = [ 7 ];
    };
    "Mod+Shift+8" = {
      action.move-column-to-workspace = [ 8 ];
    };
    "Mod+Shift+9" = {
      action.move-column-to-workspace = [ 9 ];
    };
    "Mod+BracketLeft" = {
      action.consume-or-expel-window-left = [ ];
    };
    "Mod+BracketRight" = {
      action.consume-or-expel-window-right = [ ];
    };
    "Mod+Period" = {
      action.expel-window-from-column = [ ];
    };
    "Mod+R" = {
      action.switch-preset-column-width = [ ];
    };
    "Mod+Shift+R" = {
      action.switch-preset-window-height = [ ];
    };
    "Mod+Ctrl+R" = {
      action.reset-window-height = [ ];
    };
    "Mod+Ctrl+F" = {
      action.expand-column-to-available-width = [ ];
    };
    "Mod+C" = {
      action.center-column = [ ];
    };
    "Mod+Ctrl+C" = {
      action.center-visible-columns = [ ];
    };
    "Mod+Minus" = {
      action.set-column-width = [ "-10%" ];
    };
    "Mod+Equal" = {
      action.set-column-width = [ "+10%" ];
    };
    "Mod+Shift+Minus" = {
      action.set-window-height = [ "-10%" ];
    };
    "Mod+Shift+Equal" = {
      action.set-window-height = [ "+10%" ];
    };
    "XF86Launch1" = {
      action.screenshot = [ ];
    };
    "Ctrl+XF86Launch1" = {
      action.screenshot-screen = [ ];
    };
    "Alt+XF86Launch1" = {
      action.screenshot-window = [ ];
    };
    "Print" = {
      action.screenshot = [ ];
    };
    "Ctrl+Print" = {
      action.screenshot-screen = [ ];
    };
    "Alt+Print" = {
      action.screenshot-window = [ ];
    };
    "Mod+Escape" = {
      allow-inhibiting = false;
      action.toggle-keyboard-shortcuts-inhibit = [ ];
    };
    "Mod+Shift+P" = {
      action.power-off-monitors = [ ];
    };
  };
}
