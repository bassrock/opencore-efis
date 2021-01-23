#!/usr/bin/env bash

if [ "$2" == "pre-start" ]
then
# First release devices from their current driver (by their PCI bus IDs)
#wifi/bt
echo 0000:25:00.0 > /sys/bus/pci/devices/0000:25:00.0/driver/unbind
#usb
echo 0000:27:00.1 > /sys/bus/pci/devices/0000:27:00.1/driver/unbind
echo 0000:27:00.3 > /sys/bus/pci/devices/0000:27:00.3/driver/unbind
echo 0000:2e:00.3 > /sys/bus/pci/devices/0000:2e:00.3/driver/unbind
echo 0000:2e:00.4 > /sys/bus/pci/devices/0000:2e:00.4/driver/unbind
#vega
echo 0000:2c:00.0 > /sys/bus/pci/devices/0000:2c:00.0/driver/unbind
echo 0000:2c:00.1 > /sys/bus/pci/devices/0000:2c:00.1/driver/unbind
#nvme
echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind

# Then attach them by ID to VFIO
#wifi/bt
echo 14e4 43a0 > /sys/bus/pci/drivers/vfio-pci/new_id

#usb controllsers
echo 1022 149c > /sys/bus/pci/drivers/vfio-pci/new_id

#vega
echo 1002 687f > /sys/bus/pci/drivers/vfio-pci/new_id
echo 1002 aaf8 > /sys/bus/pci/drivers/vfio-pci/new_id

#nvme

echo 1987 5012 > /sys/bus/pci/drivers/vfio-pci/new_id
fi