
#phase 1
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime
hwclock --systohc
echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=se-latin1" > /etc/vconsole.conf
echo "127.0.0.1 localhost" > /etc/hostname

#SCript stops execution after mkinitcpio
mkinitcpio -P



#phase 2

yes | pacman -Syu
yes | pacman -S nano
yes | pacman -S git
yes | pacman -S alacritty
yes | pacman -S iwd
systemctl enable iwd
yes | pacman -S dhcpcd
yes | pacman -S sudo

useradd -m voron
echo "voron:3947" | chpasswd
echo "root:3947" | chpasswd

echo "Voron ALL=(ALL:ALL) ALL" > /etc/sudoers
echo "Defaults:Voron	!authenticate" > /etc/sudoers

yes | pacman -S grub
yes | pacman -S efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

printf "\n y\n" | pacman -S xorg

yes | pacman -S nvidia

Xorg :0 -configure
printf "\n\n\n\n\n y\n" | pacman -S plasma

systemctl set-default graphical.target
systemctl enable sddm

setxkbmap sv

yes | pacman -S firefox
yes | pacman -S discord


#systemctl enalbe dhcpcd@ens33