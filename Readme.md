![screenshot](./screenshot.png)

Core
```
sudo pacman -S --needed \
\
base-devel yay xmonad xmonad-contrib xmonad-utils polybar rofi \
\
alacritty vim ranger zsh git xorg-xkill nitrogen neofetch pamixer playerctl \
\
lxappearance gnome-control-center nautilus gnome-screenshot gnome-calendar gnome-calculator gnome-disk-utility guake brave-browser pavucontrol
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

[SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```
ssh-keygen -t ed25519 -C "alexkopen@gmail.com"
```

```
git config --global user.email "alexkopen@gmail.com" && git config --global user.name "Alex Kopen" && git config --global pull.rebase false
```

[AMD Screen Tearing](https://davejansen.com/quick-how-to-fix-screen-tearing-in-ubuntu-with-amd-gpus/)

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
