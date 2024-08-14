#!/usr/bin/env bash

# Variables
VAR_NAME=$1
VAR_VALUE=$2

# Main
if [ "$#" -ne 2 ]; then
    echo "Error: Please provide both variable name and value as parameters."
    exit 1
else
    # Check if the variable already exists
    if grep -q "^export $VAR_NAME=" ~/.bashrc; then
        # Update existing variable
        sed -i "s/^export $VAR_NAME=.*/export $VAR_NAME=$VAR_VALUE/" ~/.bashrc
    else
        # Create new variable
        echo "export $VAR_NAME=$VAR_VALUE" >> ~/.bashrc
    fi

    # Set the variable for the current session
    export $VAR_NAME=$VAR_VALUE

    # Source the .bashrc file to apply changes in the current session
    source ~/.bashrc

    echo "Variable '$VAR_NAME' with value '$VAR_VALUE' has been saved to .bashrc."
fi
