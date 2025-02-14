#!/bin/bash

MINTER_IDENTITY_NAME="fastai-minter"

# Obtener el principal de la identidad MINTER
MINTER_PRINCIPAL=$(dfx identity get-principal --identity=$MINTER_IDENTITY_NAME)

if [ -z "$MINTER_PRINCIPAL" ]; then
    echo "No principal found. Creating new identity..."
    dfx identity new $MINTER_IDENTITY_NAME    
else
    echo "Minter Principal found: $MINTER_PRINCIPAL"
fi

# Llamada al script icp.sh, pasándole el nombre de la identidad MINTER como argumento
sh $PWD/scripts/tokens/icp.sh $MINTER_IDENTITY_NAME
