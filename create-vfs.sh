#!/bin/bash
# Create VFs

# Initialize ens2f2 VF
for i in {1..10}; do
  if [[ -e /sys/class/net/ens2f2 ]]; then
    echo 8 > /sys/class/net/ens2f2/device/sriov_numvfs
    break
  fi
  echo "Waiting for ens2f2 to appear..."
  sleep 1
done

# Initialize ens2f1 VF
for i in {1..10}; do
  if [[ -e /sys/class/net/ens2f1 ]]; then
    echo 9 > /sys/class/net/ens2f1/device/sriov_numvfs
    break
  fi
  echo "Waiting for ens2f1 to appear..."
  sleep 1
done

# Wait for ens2f2 VF interfaces to be created
for i in {1..10}; do
  if ip link show ens2f2v0 && ip link show ens2f2v1; then
    break
  fi
  echo "Waiting for VFs ens2f2v0 and ens2f2v1..."
  sleep 1
done

# DHCP + M-Plane
ip link set ens2f2 vf 1 mac 00:1D:AC:00:00:01 vlan 0
# DHCP + M-Plane IP setup
ip link set ens2f2v1 up
ip addr add 10.22.17.155/32 dev ens2f2v1

############### O-RU 1 SETUP #################

# DU0 - O-RU 1
ip link set ens2f2 vf 0 mac 72:0e:9b:5f:81:e0 vlan 0

# CU0
ip link set ens2f2 vf 2 mac 00:1D:AC:00:10:01 vlan 0
# DU0 - CU0
ip link set ens2f2 vf 3 mac 00:1D:AC:00:10:02 vlan 0

# DU1 - O-RU 1
ip link set ens2f2 vf 4 mac 72:0e:9b:5f:81:e0 vlan 0
# DU1 - CU0
ip link set ens2f2 vf 5 mac 00:1D:AC:00:10:03 vlan 0

# DU2 - O-RU 1
ip link set ens2f2 vf 6 mac 72:0e:9b:5f:81:e0 vlan 0
# DU2 - CU0
ip link set ens2f2 vf 7 mac 00:1D:AC:00:10:04 vlan 0

# Misc
ip link set ens2f2 vf 0 spoofchk off
ip link set ens2f2v0 mtu 9000
ip link set ens2f2 vf 4 spoofchk off
ip link set ens2f2v4 mtu 9000
ip link set ens2f2 vf 6 spoofchk off
ip link set ens2f2v6 mtu 9000
ip link set ens2f2v2 mtu 9000
ip link set ens2f2v3 mtu 9000
ip link set ens2f2v5 mtu 9000
ip link set ens2f2v7 mtu 9000

############### O-RU 0 SETUP #################

# Wait for ens2f1 VF interfaces to be created
for i in {1..10}; do
  if ip link show ens2f1v0 && ip link show ens2f1v1; then
    break
  fi
  echo "Waiting for VFs ens2f1v0 and ens2f1v1..."
  sleep 1
done

# DU3 - O-RU 0
ip link set ens2f1 vf 0 mac 72:0e:9b:5f:81:e1 vlan 0
# DU3 - CU0
ip link set ens2f1 vf 1 mac 00:1D:AC:00:10:05

# DU4 - O-RU 0
ip link set ens2f1 vf 2 mac 72:0e:9b:5f:81:e1 vlan 0
# DU4 - CU0
ip link set ens2f1 vf 3 mac 00:1D:AC:00:10:06

# DU5 - O-RU 0
ip link set ens2f1 vf 4 mac 72:0e:9b:5f:81:e1 vlan 0
# DU5 - CU0
ip link set ens2f1 vf 5 mac 00:1D:AC:00:10:07

# Misc
ip link set ens2f1 vf 0 spoofchk off
ip link set ens2f1v0 mtu 9000
ip link set ens2f1 vf 2 spoofchk off
ip link set ens2f1v2 mtu 9000
ip link set ens2f1 vf 4 spoofchk off
ip link set ens2f1v4 mtu 9000
ip link set ens2f1v1 mtu 9000
ip link set ens2f1v3 mtu 9000
ip link set ens2f1v5 mtu 9000

# New VF for triband
# CU Triband
ip link set ens2f1 vf 6 mac 00:1D:AC:00:11:00 vlan 0
# DU Triband - O-RU Triband
ip link set ens2f1 vf 7 mac 72:0e:9b:5f:82:e0 vlan 0
# DU Triband - CU Triband
ip link set ens2f1 vf 8 mac 00:1D:AC:00:11:01 vlan 0

# Misc
ip link set ens2f1 vf 7 spoofchk off
ip link set ens2f1v7 mtu 9000
