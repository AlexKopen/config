Core
```
sudo pacman -S --needed base-devel yay xmonad xmonad-contrib xmonad-utils polybar vim ranger zsh git alacritty xorg-xkill rofi xfce4-screenshooter thunar gnome-calendar galculator lxappearance xfce4-terminal pamixer playerctl brave-browser nitrogen
```

```
yay -S sublime-text-4 phpstorm phpstorm-jre spotify
```

[OhMyZsh](https://ohmyz.sh/)
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

[fnm](https://github.com/Schniz/fnm)
```
curl -fsSL https://fnm.vercel.app/install | bash
```

[SpaceVim](https://spacevim.org/)
```
curl -sLf https://spacevim.org/install.sh | bash
```

Sublime Text
```
{
    "font_size": 15,
    "ignored_packages": [],
    "word_wrap": "true"
}
```

Git
`git config --global user.email "alexkopen@gmail.com" && git config --global global user.name "Alex Kopen"`

AMD Screen Tearing
[Guide](https://davejansen.com/quick-how-to-fix-screen-tearing-in-ubuntu-with-amd-gpus/)

Directory: `etc/X11/xorg.conf.d`

File: `20-amdgpu.conf`
```
Section "Device"
        Identifier      "AMD Graphics"
        Driver          "amdgpu"
        Option          "TearFree" "true"
EndSection
```

Validate: `xrandr --verbose | grep "TearFree"`