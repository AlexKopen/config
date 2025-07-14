# Core
```
sudo apt install -y \
build-essential git xmonad libghc-xmonad-contrib-dev polybar rofi \
vim ranger zsh x11-utils nitrogen neofetch \
pavucontrol playerctl pulseaudio guake \
maim xclip xautolock lxappearance i3lock-fancy \
texlive-xetex texlive-fonts-extra qbittorrent numlockx
```

## [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

## Git

```
ssh-keygen -t ed25519 -C "alexkopen@gmail.com"
```

```
git config --global user.email "alexkopen@gmail.com" && \
git config --global user.name "Alex Kopen" && \
git config --global pull.rebase false
```


## [asdf](https://asdf-vm.com/guide/getting-started.html)

[plugins](https://github.com/asdf-vm/asdf-plugins?tab=readme-ov-file)

```
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf install golang latest
asdf global golang latest

asdf list all nodejs
asdf install nodejs 22.13.1
asdf local nodejs 22.13.1
```

## [Docker](https://docs.docker.com/engine/install/linux-postinstall/#configure-docker-to-start-on-boot)
```
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo usermod -aG docker $USER
```

## [Snapcraft](https://snapcraft.io/docs/installing-snap-on-linux-mint)
```
sudo ln -s /var/lib/snapd/snap /snap
```

## [PIA](https://www.privateinternetaccess.com/download/linux-vpn)

## [AMD Screen Tearing](https://davejansen.com/quick-how-to-fix-screen-tearing-in-ubuntu-with-amd-gpus/)

Directory: `/etc/X11/xorg.conf.d`

File: `20-amdgpu.conf`
```
Section "Device"
        Identifier      "AMD Graphics"
        Driver          "amdgpu"
        Option          "TearFree" "true"
EndSection
```

Validate: `xrandr --verbose | grep "TearFree"`

## Firefox HUD

[about:config](about:config)

`layout.css.devPixelsPerPx` 1.3

`browser.sessionstore.resume_from_crash` false

## [Jellyfin](https://jellyfin.org/docs/general/installation/linux)

## [Calibre](https://calibre-ebook.com/download_linux)

## DPI

`~/.Xresources`
```
Xft.dpi: 120
```
`xrdb -merge ~/.Xresources`

## Mouse Sensitivity
```
xinput list
xinput set-prop 17 "libinput Accel Speed" 1
```
