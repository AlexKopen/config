Core
```
sudo apt update && sudo apt install -y \
build-essential git xmonad libghc-xmonad-contrib-dev polybar rofi \
vim ranger zsh x11-utils nitrogen neofetch \
pavucontrol playerctl guake \
nemo scrot xclip xautolock lxappearance i3lock-fancy texlive-xetex texlive-fonts-extra
```

[fnm](https://github.com/Schniz/fnm#installation)

[gvm](https://github.com/moovweb/gvm)

[Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh#basic-installation)

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

[Snapcraft](https://snapcraft.io/store)
```
sudo ln -s /var/lib/snapd/snap /snap
```

[PIA](https://www.privateinternetaccess.com/download/linux-vpn)

[AMD Screen Tearing](https://davejansen.com/quick-how-to-fix-screen-tearing-in-ubuntu-with-amd-gpus/)

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

Trezor
[Desktop App](https://trezor.io/trezor-suite)

[Udev Rules](https://trezor.io/learn/a/udev-rules)
