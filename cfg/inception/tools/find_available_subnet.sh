#!/bin/bash

# *** Third test, returns another available subnet accepted by docker if first one is already used.. **
# *** (only tested for a second network, and it returned a functionnal one) **

# Define the list of possible subnets Docker will accept
subnets=(
    "192.168.0.0/16"
    "172.16.0.0/16"
    "172.17.0.0/16"
    "172.18.0.0/16"
    "172.19.0.0/16"
    "172.20.0.0/16"
)

# Function to check if a subnet is used
is_subnet_used() {
    ip route | grep -q "$1"
    docker network inspect $(docker network ls -q) | grep -q "$1"
}

# Loop through possible subnets and find the first available one
for subnet in "${subnets[@]}"; do
    if ! is_subnet_used "$subnet"; then
        echo "$subnet"
        exit 0
    fi
done

echo "Error: No available subnets found in the specified ranges."
exit 1

################################################################################

# *** Second test, returns "192.168.0.0/16" or says it is already in use.. **
#
## Define the specific subnet for Docker
#subnet="192.168.0.0"
#subnet_mask="16"
#
## Function to check if a subnet is used
#is_subnet_used() {
#    ip route | grep -q "$subnet/$subnet_mask"
#    docker network inspect $(docker network ls -q) | grep -q "$subnet/$subnet_mask"
#}
#
## Check if the specific subnet is available
#if ! is_subnet_used; then
#    echo "$subnet/$subnet_mask"
#else
#    echo "Error: Subnet $subnet/$subnet_mask is already in use."
#fi
#

################################################################################

# *** First test, kind of works ? (but need to adjust the result based on docker error messages..) **
#
## Define the network prefix and subnet mask for Docker (adjust if needed)
#network_prefix="192.168"
#subnet_mask="16"
#
## Function to check if a subnet is used
#is_subnet_used() {
#    ip route | grep -q "$1.0/$subnet_mask"
#    docker network inspect $(docker network ls -q) | grep -q "$1.0/$subnet_mask"
#}
#
## Loop through possible subnets within 192.168.0.0/16
#for i in $(seq 0 31); do
#    subnet="$network_prefix.$i"
#    if ! is_subnet_used "$subnet"; then
#        echo "$subnet.0/$subnet_mask"
#        break
#    fi
#done

################################################################################

# Sript to identify subnet for docker network

# Checks for unused subnets in the private IP range (172.16.0.0/12, 192.168.0.0/16, or 10.0.0.0/8).
# The script scans the 172.16.0.0/12 range (commonly used by Docker) and returns the first unused subnet:


# Network Prefix:
# Defines 172.18.x.0/16 as the preferred range.

# is_subnet_used Function:
# Function to check if a given subnet is currently used by checking system routes and Docker networks.

# Loop and Output:
# Scans through subnets in the range 172.18.0.0/16 to 172.18.31.0/16 and prints the first available subnet.

################################################################################
################################################################################

# Other commands to check networks:

# Display all the IP addresses assigned to network interfaces

    # ip addr show | grep "inet "

# List all IPv4 addresses and their subnets

    # ifconfig | grep "inet "

# View all Docker network subnets

    # docker networks ls

# Then, see more details (including subnets) about each network

    # docker network inspect <network-name>

# Or for all networks at once

    # docker network inspect $(docker network ls -q) | grep Subnet

# List all routes on the machine, showing which IP ranges are currently in use

    # route -n
    # (Look for lines with UG (gateway) in the Flags column, as these represent networks in use)


