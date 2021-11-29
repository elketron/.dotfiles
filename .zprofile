export GUI_EDITOR=/usr/bin/nvim
export EDITOR=/usr/bin/nvim
export BROWSER=/usr/bin/qutebrowser
export TERINAL=/usr/bin/kitty
export VISUAL=/usr/bin/nvim
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export npm_config_prefix="$HOME/.local"

var=1

if [ $var -eq 0 ]; then
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

    export XDG_CURRENT_DESKTOP=sway
    export QT_WAYLAND_FORCE_DPI=physical
    export XDG_SESSION_TYPE=wayland
    export XDG_CONFIG_HOME=~/.config
    export SDL_VIDEODRIVER=x11

    export LIBSEAT_BACKEND=logind

    dwl
    #exec dbus-run-session sway -s ./startup.sh $@
    
else 
    if [ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ]; then
        exec startx -- -keeptty -nolisten tcp > ~/.xorg.log 2>&1
    #    exec xterm
    fi
fi
