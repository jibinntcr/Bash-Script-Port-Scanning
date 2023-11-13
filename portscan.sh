#!/bin/bash

# Display usage information
echo "Usage: ./port-scanner.sh [IP] [PORT_RANGE]"
echo

# Check if an IP address is provided as an argument
if [ "$1" = "" ]; then
  echo "Error: Please provide an IP address."
  echo "Usage: ./port-scanner.sh [IP] [PORT_RANGE]"
  exit 1
fi

# Set a default port range or allow the user to provide it as an argument
PORT_RANGE=${2:-1-65535}

# Inform the user that port scanning is in progress
echo "Please wait while it is scanning all the open ports..."

# Use netcat to scan for open ports in the specified range on the specified IP address
nc -nvz $1 $PORT_RANGE > $1.txt 2>&1

# Sort the output numerically and display it
sort -n $1.txt

# Remove the temporary file created during the scan
rm -rf $1.txt
