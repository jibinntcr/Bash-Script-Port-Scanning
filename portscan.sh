#!/bin/bash

# Port Scanner Script -jibinn@mulearn

# Display script usage
show_usage() {
    echo "Usage: $0 -h <host_address> -r <max_port_range>"
    exit 1
}

# Check if a port is open
is_port_open() {
    (echo > /dev/tcp/$host/$1) > /dev/null 2>&1
}

# Set default values
host=""
max_ports=""

# Parse command-line arguments using getopts
while getopts "h:r:" option; do
    case $option in
        h)
            host="$OPTARG"
            ;;
        r)
            max_ports="$OPTARG"
            ;;
        *)
            show_usage
            ;;
    esac
done

# Check if the required options are provided
if [[ -z $host || -z $max_ports ]]; then
    show_usage
fi

# Scan and display open ports
for ((port_number = 1; port_number <= max_ports; port_number++)); do
    # Check if the port is open using the is_port_open function
    if is_port_open "$port_number"; then
        echo "$host:$port_number is open"
    fi
done
