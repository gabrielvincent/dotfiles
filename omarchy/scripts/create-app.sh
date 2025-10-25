#!/bin/bash

# Check if required parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Error: Missing required parameters!"
    echo ""
    echo "Missing:"
    [ -z "$1" ] && echo "  - app_name (parameter 1)"
    [ -z "$2" ] && echo "  - class (parameter 2)"
    echo ""
    echo "Usage: $0 <app_name> <class>"
    echo "Example: $0 myapp myclass"
    exit 1
fi

app_name=$1
app_class=$2

mv ~/.local/share/applications/"$app_name".desktop ~/.config/omarchy/applications && \
echo "StartupWMClass=$app_class" >> ~/.config/omarchy/applications/"$app_name".desktop && \
ln -s ~/.config/omarchy/applications/"$app_name".desktop ~/.local/share/applications/"$app_name".desktop && \
update-desktop-database ~/.local/share/applications
