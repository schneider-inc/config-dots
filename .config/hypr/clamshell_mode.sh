if [[ "$(hyprctl monitors)" =~ "\s(DP-|HDMI-)+"  ]]; then
  if [[ $1 == "open" ]]; then
    hyprctl keyword monitor "eDP-1,2560x1600,2794x1440,1.6,vrr,1"
  else
    hyprctl keyword monitor "eDP-1,disable"
  fi
fi

