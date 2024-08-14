
#!/usr/bin/env bash

# Variables

TOKEN=$1

# Main

export GITHUB_TOKEN=$TOKEN
echo "GITHUB_TOKEN is $GITHUB_TOKEN"
echo "you can make it permanent by adding this line to the .bashrc file"

# Exit code

exit 0