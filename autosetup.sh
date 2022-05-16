loadkeys sv-latin1
timedatectl set-ntp true

printf "g\n n\n\n\n +1G\n t\n 1\n w\n" | fdisk /dev/sda
printf "n\n\n\n +16G\n t\n\n 19\n w\n" | fdisk /dev/sda
printf "n\n\n\n\n t\n\n 23\n w\n" | fdisk /dev/sda

mkfs.ext4 /dev/sda3
mkswap /dev/sda2
mkfs.fat -F 32 /dev/sda1

mount /dev/sda3 /mnt
swapon /dev/sda2
mount --mkdir /dev/sda1 /mnt/boot


pacstrap /mnt base linux-lts linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

cp pack.sh /mnt
./pack.sh
