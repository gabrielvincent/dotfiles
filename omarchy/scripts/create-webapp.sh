#!/bin/bash

# Check if required parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing required parameters!"
    echo ""
    echo "Missing:"
    [ -z "$1" ] && echo "  - app_name (parameter 1)"
    [ -z "$2" ] && echo "  - app_url (parameter 2)"
    echo ""
    echo "Usage: $0 <app_name> <app_url>"
    echo "Example: $0 myapp example.com"
    exit 1
fi

app_name=$1
app_url="chrome-""$2""__-Default"

mv ~/.local/share/applications/"$app_name".desktop ~/.config/omarchy/applications && \
echo "StartupWMClass=$app_url" >> ~/.config/omarchy/applications/"$app_name".desktop && \
ln -s ~/.config/omarchy/applications/"$app_name".desktop ~/.local/share/applications/"$app_name".desktop && \
update-desktop-database ~/.local/share/applications/update-desktop-database ~/.local/share/applications
