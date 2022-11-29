#Configures the settings
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=se-latin1" > /etc/vconsole.conf
echo "127.0.0.1 localhost" > /etc/hostname

#Compiles recent changes
mkinitcpio -P

#Installs shit I'll be using
yes | pacman -Syu
yes | pacman -S nano
yes | pacman -S iwd
systemctl enable iwd
yes | pacman -S dhcpcd
yes | pacman -S sudo
yes | pacman -S discord

#Creates account, changes passwords and configures sudoers
useradd -m voron
echo "voron:3947" | chpasswd
echo "root:3947" | chpasswd
echo "voron ALL=(ALL:ALL) ALL" > /etc/sudoers
echo "Defaults:voron	!authenticate" > /etc/sudoers

#Installs and configures grub bootloader
yes | pacman -S grub
yes | pacman -S efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

#Installs and configures the graphics
printf "\n y\n" | pacman -S xorg
yes | pacman -S nvidia
Xorg :0 -configure
systemctl set-default graphical.target
setxkbmap se

#Testing purposes only
#systemctl enalbe dhcpcd@ens33

