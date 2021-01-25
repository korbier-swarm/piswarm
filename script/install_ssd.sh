#!/bin/bash
echo '#### Creation des partitions sur /dev/sda'
sudo sfdisk /dev/sda < sda.sfdisk
sudo mkfs.ext4 /dev/sda2
sudo mkfs.ext4 /dev/sda3

echo '#### Mise à jour du fstab'
echo '/dev/sda2 /var/log ext4 rw,relatime 0 0' | sudo tee -a /etc/fstab
echo '/dev/sda3 /home ext4 defaults 0 2' | sudo tee -a /etc/fstab

echo '### Configuration du swap'
sudo mkswap /dev/sda1
sudo swapon /dev/sda1

echo '### Configuration de /var/log'
sudo service rsyslog stop
mkdir -p /tmp/varlog
sudo cp -r /var/log/* /tmp/varlog
sudo mount /dev/sda2 /var/log
sudo cp -r /tmp/varlog/* /var/log
sudo rm -rf /tmp/varlog
sudo service rsyslog start

echo '### Configuration de /home'
mkdir -p /tmp/home
sudo cp -r /home/* /tmp/home
sudo mount /dev/sda3 /home
sudo cp -r /tmp/home/* /home
sudo rm -rf /tmp/home
sudo chown -R pi.pi /home/pi
