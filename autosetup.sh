#Prob don't need this
loadkeys sv-latin1
timedatectl set-ntp true

#Creates the cluster 4GB on efi, 16GB on swap, and remaining on root
printf "g\n n\n\n\n +4G\n t\n 1\n n\n\n\n +16G\n t\n\n 19\n n\n\n\n\n t\n\n 23\n w\n" | fdisk /dev/sda

#Formats the cluster
mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1

#Mounts the cluster
mount /dev/sda3 /mnt
swapon /dev/sda2
mount --mkdir /dev/sda1 /mnt/boot

#Installs linux kernel
pacstrap /mnt base linux-lts linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

#Starts next script
chmod +x pack.sh
cp pack.sh /mnt
arch-chroot /mnt ./pack.sh
