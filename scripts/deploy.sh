#!/bin/bash

sh $PWD/scripts/core/internet_identity.sh

MINTER_IDENTITY_NAME="swapy-minter"

# Obtener el principal de la identidad MINTER
MINTER_PRINCIPAL=$(dfx identity get-principal --identity=$MINTER_IDENTITY_NAME)

if [ -z "$MINTER_PRINCIPAL" ]; then
    echo "No principal found. Creating new identity..."
    dfx identity new $MINTER_IDENTITY_NAME    
else
    echo "Minter Principal found: $MINTER_PRINCIPAL"
fi

sh $PWD/scripts/tokens/icp.sh $MINTER_IDENTITY_NAME
