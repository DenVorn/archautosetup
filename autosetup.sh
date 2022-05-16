loadkeys sv-latin1
timedatectl set-ntp true

printf "g\n n\n\n\n +1G\n t\n 1\n w\n" | fdisk /dev/sda
printf "n\n\n\n +16G\n t\n\n 19\n w\n" | fdisk /dev/sda
printf "n\n\n\n\n t\n\n 23\n w\n" | fdisk /dev/sda

mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1

mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
swapon /dev/sda2

pacstrap /mnt base linux-lts linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

mount --mkdir /dev/sdb1 /hey
cd /hey/hey
./pack.sh