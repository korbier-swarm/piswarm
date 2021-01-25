#!/bin/bash
echo '#### Mise à jour du fstab'
echo '/dev/sda2 /var/log ext4 rw,relatime 0 0' | sudo tee -a /etc/fstab
echo '/dev/sda3 /home ext4 defaults 0 2' | sudo tee -a /etc/fstab

echo '### Configuration du swap'
sudo mkswap /dev/sda1
sudo swapon /dev/sda1
