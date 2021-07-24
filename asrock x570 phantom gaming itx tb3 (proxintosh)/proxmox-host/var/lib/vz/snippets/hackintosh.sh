#!/usr/bin/env bash

if [ "$2" == "pre-start" ]
then
# First release devices from their current driver (by their PCI bus IDs)
#wifi/bt
echo vfio-pci > /sys/bus/pci/devices/0000\:25\:00.0/driver_override

#usb
echo vfio-pci > /sys/bus/pci/devices/0000\:27\:00.1/driver_override
echo vfio-pci > /sys/bus/pci/devices/0000\:27\:00.3/driver_override
echo vfio-pci > /sys/bus/pci/devices/0000\:2e\:00.3/driver_override
echo vfio-pci > /sys/bus/pci/devices/0000\:2e\:00.4/driver_override

#vega
echo vfio-pci > /sys/bus/pci/devices/0000\:2c\:00.0/driver_override
echo vfio-pci > /sys/bus/pci/devices/0000\:2c\:00.1/driver_override

#nvme
echo vfio-pci > /sys/bus/pci/devices/0000\:03\:00.0/driver_override
fi
