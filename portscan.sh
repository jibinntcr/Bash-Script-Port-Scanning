#!/bin/bash

# Function to display script usage
usage() {
    echo "Usage: $0 -i <IP_address> -p <max_port_range>"
    exit 1
}

# Function to check if a port is open
is_port_open() {
    (echo > /dev/tcp/$ip/$1) > /dev/null 2>&1
}

# Set default values
ip=""
ports=""

# Parse command line arguments using getopts
while getopts "i:p:" opt; do
    case $opt in
        i)
            ip="$OPTARG"
            ;;
        p)
            ports="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

# Check if the required options are provided
if [[ -z $ip || -z $ports ]]; then
    usage
fi

# Scan and display open ports
for ((port = 1; port <= ports; port++)); do
    # Check if the port is open using the is_port_open function
    if is_port_open "$port"; then
        echo "$ip:$port is open"
    fi
done
