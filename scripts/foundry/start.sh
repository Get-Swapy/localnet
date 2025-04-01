#!/bin/bash

# Parse command line arguments
DEBUG_MODE=false
while getopts "d" opt; do
  case $opt in
    d) DEBUG_MODE=true ;;
    *) ;;
  esac
done

# Find process IDs listening on port 8545 (anvil)
anvil=$(lsof -t -i:8545)

# Check if any Anvil PIDs were found
if [ -z "$anvil" ]; then
    if [ "$DEBUG_MODE" = true ]; then
        echo "Starting Anvil in debug mode..."
        RUST_LOG=backend,api,node,rpc=warn anvil --slots-in-an-epoch 1 &
    else
        echo "Starting Anvil in normal mode..."
        anvil --slots-in-an-epoch 1 &
    fi
else
    echo "Anvil already running."
fi

# Find process IDs listening on port 8545 (caddy)
caddy_server=$(lsof -t -i:2019)

# Check if any Caddy PIDs were found
if [ -z "$caddy_server" ]; then
    caddy start
else
    echo "Caddy server already running."
fi
