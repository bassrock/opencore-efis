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

2. Install Linux Headers

```
apt install pve-headers-$(uname -r)
```

2. Install vendor-reset <https://github.com/gnif/vendor-reset>

Perform these after you install things in proxmox

```
update-initramfs -u -k all
update-grub
pve-efiboot-tool refresh
reboot
```

### Getting Docker To Work

#### Proxmox

1. Install docker <https://docs.docker.com/engine/install/debian/> in proxmox
2. Install nfs and autofs in proxmox

```
apt install autofs nfs-client nfs-server
```

3. Ensure there is a host to guest network setup where the host is at 10.10.10.1 and guest at 10.10.10.1
4. Copy all files in etc if you have not
5. Start autofs

```
systemctl start autofs
systemctl enable autofs
```

#### Mac

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

### LSPCI -KK

The following is the output of `lspci -kk` for this machine

```bash
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge
 Kernel driver in use: pcieport
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge
 Kernel driver in use: pcieport
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:05.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:07.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:07.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B]
 Kernel driver in use: pcieport
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B]
 Kernel driver in use: pcieport
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 61)
 Subsystem: ASRock Incorporation FCH SMBus Controller
 Kernel driver in use: piix4_smbus
 Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
 Subsystem: ASRock Incorporation FCH LPC Bridge
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 3
 Kernel driver in use: k10temp
 Kernel modules: k10temp
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57ad
 Kernel driver in use: pcieport
02:01.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a3
 Kernel driver in use: pcieport
02:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a3
 Kernel driver in use: pcieport
02:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a3
 Kernel driver in use: pcieport
02:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a3
 Kernel driver in use: pcieport
02:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a4
 Kernel driver in use: pcieport
02:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a4
 Kernel driver in use: pcieport
02:0a.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 57a4
 Kernel driver in use: pcieport
03:00.0 Non-Volatile memory controller: Phison Electronics Corporation E12 NVMe Controller (rev 01)
 Subsystem: Phison Electronics Corporation E12 NVMe Controller
 Kernel driver in use: vfio-pci
04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] (rev 06)
 Kernel driver in use: pcieport
05:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] (rev 06)
 Kernel driver in use: pcieport
05:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] (rev 06)
 Kernel driver in use: pcieport
05:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] (rev 06)
 Kernel driver in use: pcieport
06:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 2C 2018] (rev 06)
 Subsystem: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 2C 2018]
 Kernel modules: thunderbolt
08:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 2C 2018] (rev 06)
 Subsystem: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 2C 2018]
 Kernel modules: xhci_pci
25:00.0 Network controller: Broadcom Limited BCM4360 802.11ac Wireless Network Adapter (rev 03)
 Subsystem: Apple Inc. BCM4360 802.11ac Wireless Network Adapter
 Kernel driver in use: vfio-pci
 Kernel modules: bcma
26:00.0 Ethernet controller: Intel Corporation I211 Gigabit Network Connection (rev 03)
 Subsystem: ASRock Incorporation I211 Gigabit Network Connection
 Kernel driver in use: igb
 Kernel modules: igb
27:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP
 Kernel driver in use: vfio-pci
27:00.1 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
 Subsystem: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
 Kernel driver in use: vfio-pci
 Kernel modules: xhci_pci
27:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
 Subsystem: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
 Kernel driver in use: vfio-pci
 Kernel modules: xhci_pci
28:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 51)
 Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode]
 Kernel driver in use: ahci
 Kernel modules: ahci
29:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 51)
 Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode]
 Kernel driver in use: ahci
 Kernel modules: ahci
2a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1470 (rev c3)
 Kernel driver in use: pcieport
2b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 1471
 Kernel driver in use: pcieport
2c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] (rev c3)
 Subsystem: Micro-Star International Co., Ltd. [MSI] Vega 10 XL/XT [Radeon RX Vega 56/64]
 Kernel driver in use: vfio-pci
 Kernel modules: amdgpu
2c:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10 HDMI Audio [Radeon Vega 56/64]
 Subsystem: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10 HDMI Audio [Radeon Vega 56/64]
 Kernel driver in use: vfio-pci
 Kernel modules: snd_hda_intel
2d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function
2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP
 Kernel driver in use: vfio-pci
2e:00.1 Encryption controller: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP
 Subsystem: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP
 Kernel driver in use: ccp
 Kernel modules: ccp
2e:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller
 Subsystem: ASRock Incorporation Matisse USB 3.0 Host Controller
 Kernel driver in use: vfio-pci
 Kernel modules: xhci_pci
2e:00.4 Audio device: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller
 Subsystem: ASRock Incorporation Starship/Matisse HD Audio Controller
 Kernel driver in use: vfio-pci
 Kernel modules: snd_hda_intel
```

### IOMMU Groups

```bash
IOMMU Group 0:
 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 1:
 00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU Group 10:
 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU Group 11:
 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 61)
 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
IOMMU Group 12:
 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 0 [1022:1440]
 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 1 [1022:1441]
 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 2 [1022:1442]
 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 3 [1022:1443]
 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 4 [1022:1444]
 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 5 [1022:1445]
 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 6 [1022:1446]
 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Matisse Device 24: Function 7 [1022:1447]
IOMMU Group 13:
 01:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57ad]
IOMMU Group 14:
 02:01.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a3]
IOMMU Group 15:
 02:02.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a3]
IOMMU Group 16:
 02:04.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a3]
IOMMU Group 17:
 02:05.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a3]
IOMMU Group 18:
 02:08.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a4]
 27:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
 27:00.1 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
 27:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
IOMMU Group 19:
 02:09.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a4]
 28:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
IOMMU Group 2:
 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 20:
 02:0a.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:57a4]
 29:00.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
IOMMU Group 21:
 03:00.0 Non-Volatile memory controller [0108]: Phison Electronics Corporation E12 NVMe Controller [1987:5012] (rev 01)
IOMMU Group 22:
 04:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06)
IOMMU Group 23:
 05:00.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06)
IOMMU Group 24:
 05:01.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06)
IOMMU Group 25:
 05:02.0 PCI bridge [0604]: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 2C 2018] [8086:15e7] (rev 06)
IOMMU Group 26:
 06:00.0 System peripheral [0880]: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 2C 2018] [8086:15e8] (rev 06)
IOMMU Group 27:
 08:00.0 USB controller [0c03]: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 2C 2018] [8086:15e9] (rev 06)
IOMMU Group 28:
 25:00.0 Network controller [0280]: Broadcom Limited BCM4360 802.11ac Wireless Network Adapter [14e4:43a0] (rev 03)
IOMMU Group 29:
 26:00.0 Ethernet controller [0200]: Intel Corporation I211 Gigabit Network Connection [8086:1539] (rev 03)
IOMMU Group 3:
 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 30:
 2a:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1470] (rev c3)
IOMMU Group 31:
 2b:00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1471]
IOMMU Group 32:
 2c:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10 XL/XT [Radeon RX Vega 56/64] [1002:687f] (rev c3)
IOMMU Group 33:
 2c:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Vega 10 HDMI Audio [Radeon Vega 56/64] [1002:aaf8]
IOMMU Group 34:
 2d:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Function [1022:148a]
IOMMU Group 35:
 2e:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Reserved SPP [1022:1485]
IOMMU Group 36:
 2e:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Cryptographic Coprocessor PSPCPP [1022:1486]
IOMMU Group 37:
 2e:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Matisse USB 3.0 Host Controller [1022:149c]
IOMMU Group 38:
 2e:00.4 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse HD Audio Controller [1022:1487]
IOMMU Group 4:
 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse GPP Bridge [1022:1483]
IOMMU Group 5:
 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 6:
 00:05.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 7:
 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
IOMMU Group 8:
 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse Internal PCIe GPP Bridge 0 to bus[E:B] [1022:1484]
IOMMU Group 9:
 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Starship/Matisse PCIe Dummy Host Bridge [1022:1482]
```
