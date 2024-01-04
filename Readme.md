Core
```
sudo pacman -S --needed \
\
base-devel git yay xmonad xmonad-contrib xmonad-utils polybar rofi \
\
alacritty vim ranger zsh go python3 python-pip xorg-xkill nitrogen neofetch \
\
pamixer playerctl guake \
\
brave-browser docker docker-compose nemo scrot xclip xautolock
```

```
yay -S visual-studio-code-bin phpstorm phpstorm-jre goland goland-jre \
\
spotify postman-bin i3lock-fancy qbittorrent-enhanced
```

[fnm](https://github.com/Schniz/fnm#installation)
```
curl -fsSL https://fnm.vercel.app/install | bash
```

[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

[Docker](https://docs.docker.com/engine/install/linux-postinstall/#configure-docker-to-start-on-boot)
```
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo usermod -aG docker $USER
```

Git

[SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```
ssh-keygen -t ed25519 -C "alexkopen@gmail.com"
```

```
git config --global user.email "alexkopen@gmail.com" && \
git config --global user.name "Alex Kopen" && \
git config --global pull.rebase false
```

[PIA](https://www.privateinternetaccess.com/download/linux-vpn)

GTK Programs Slow to Launch
```
sudo pacman -R xdg-desktop-portal-gnome gnome-keyring
```

Force Gnome Dark Theme
```
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
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

Theming
```
lxappearance
xfce4-appearance-settings
```
