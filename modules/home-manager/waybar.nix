{ pkgs, ... }:

{
  xdg.configFile."waybar/config.json".text = ''
    {
      "layer": "top",
      "position": "top",

      "modules-left": ["launcher", "workspaces", "tray"],
      "modules-center": ["clock"],
      "modules-right": [
        "network",
        "pulseaudio",
        "backlight",
        "battery",
        "custom/darkmode",
        "custom/reboot",
        "custom/poweroff"
      ],

      "launcher": {
        "icon": " 🚀",
        "on-click": "wofi --show drun",
        "tooltip": "Launch Applications"
      },

      "clock": {
        "format": "🕒 {:%a %d %b %H:%M}",
        "tooltip-format": "📅 {:%Y-%m-%d %H:%M:%S}"
      },

      "network": {
        "format-wifi": "📶 {essid} ({signalStrength}%)",
        "format-ethernet": "🔌 {ifname}",
        "format-disconnected": "❌ Disconnected"
      },

      "pulseaudio": {
        "format": "🔊 {volume}%",
        "format-muted": "🔇 Muted",
        "on-click": "pavucontrol"
      },

      "backlight": {
        "format": "💡 {percent}%"
      },

      "battery": {
        "format": "🔋 {capacity}%",
        "format-charging": "⚡ {capacity}%"
      },

      "custom/darkmode": {
        "format": "🌗",
        "tooltip": "Toggle Dark/Light Mode",
        "on-click": "notify-send 'Toggle dark mode (implement script)'"
      },

      "custom/reboot": {
        "format": "🔄",
        "tooltip": "Reboot",
        "on-click": "systemctl reboot"
      },

      "custom/poweroff": {
        "format": "⏻",
        "tooltip": "Power Off",
        "on-click": "systemctl poweroff"
      }
    }
  '';

  xdg.configFile."waybar/style.css".text = ''
    * {
      font-family: "FiraCode Nerd Font", "Noto Sans", "Font Awesome", sans-serif;
      font-size: 14px;
    }

    window {
      background: #232946;
      color: #eebbc3;
      border-radius: 8px;
      border: 2px solid #3e4c6d;
    }

    /* Generic module styling */
    #workspaces button,
    #clock,
    #tray,
    #network,
    #pulseaudio,
    #backlight,
    #battery,
    #custom-darkmode,
    #custom-reboot,
    #custom-poweroff,
    #launcher {
      background: #232946;
      color: #eebbc3;
      border-radius: 4px;
      margin: 2px;
      padding: 0 10px;
    }

    /* Special launcher color */
    #launcher {
      background: #3e4c6d;
    }

    /* Hover effects */
    #custom-darkmode:hover,
    #custom-reboot:hover,
    #custom-poweroff:hover,
    #launcher:hover {
      background: #eebbc3;
      color: #232946;
    }
  '';
}
