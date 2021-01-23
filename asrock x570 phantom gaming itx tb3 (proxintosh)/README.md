Concepts taken from <https://github.com/Pavo-IM/Proxintosh/tree/master/Big_Sir>

1. Update sources for apt

```
cat << EOF >> /etc/apt/sources.list
deb http://download.proxmox.com/debian/pve buster pve-no-subscription
EOF
rm -rf /etc/apt/sources.list.d/pve-enterprise.list
apt update
apt install git vim -y
apt upgrade
```

2. Install vendor-reset <https://github.com/gnif/vendor-reset>


Perform these after you install things in proxmox
```
update-initramfs -u -k all
update-grub
pve-efiboot-tool refresh
reboot
```

Getting Docker To Work

Proxmox:

1. Install docker <https://docs.docker.com/engine/install/debian/> in proxmox
2. Install nfs and autofs in proxmox
3. Ensure there is a host to guest network setup where the host is at 10.10.10.1 and guest at 10.10.10.1
4. Copy all files in etc if you have not
5. Start autofs

```
systemctl start autofs
systemctl enable autofs
```

Mac:

1. Install <https://github.com/bassrock/homebrew-docker-gobetween>

```
brew tap bassrock/homebrew-docker-gobetween
brew install docker-gobetween
brew services start docker-gobetween
```

2. Setup your ssh key on Mac & proxmox so that you can do ssh root@10.10.10.1 without a password. Add your mac ssh key to proxmox's authorized keys.

3. Update mac nfs

```
sudo cp /etc/nfs.conf /etc/nfs.conf.bak && \
      echo "nfs.server.mount.require_resv_port = 0" | \
        sudo tee /etc/nfs.conf > /dev/null
```

4. Copy /etc/exports to mac and restart nfsd

```
  sudo nfsd restart ; sleep 2 && sudo nfsd checkexports
```

5. docker-machine setup

```
docker-machine create
--driver generic \
--generic-ip-address=10.10.10.1
--generic-ssh-user=root
```