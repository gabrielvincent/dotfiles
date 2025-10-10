#!/bin/bash

vdirsyncer sync

rm ~/.local/share/calcurse/apts
rm ~/.local/share/calcurse/todo

# Script to recursively import all .ics files from ~/.calendars into calcurse

CALENDAR_DIR="$HOME/.calendars"

# Check if the calendar directory exists
if [ ! -d "$CALENDAR_DIR" ]; then
    echo "Error: Calendar directory $CALENDAR_DIR does not exist"
    exit 1
fi

# Count total .ics files
total_files=$(find "$CALENDAR_DIR" -type f -name "*.ics" | wc -l)

if [ "$total_files" -eq 0 ]; then
    echo "No .ics files found in $CALENDAR_DIR"
    exit 0
fi

echo "Found $total_files .ics file(s) to import"
echo "Importing into calcurse..."
echo ""

# Counter for imported files
count=0

# Find and import all .ics files
while IFS= read -r -d '' ics_file; do
    count=$((count + 1))
    echo "[$count/$total_files] Importing: $ics_file"
    
    # Import the file into calcurse
    if calcurse -i "$ics_file" 2>/dev/null; then
        echo "  ✓ Success"
    else
        echo "  ✗ Failed to import $ics_file"
    fi
    
done < <(find "$CALENDAR_DIR" -type f -name "*.ics" -print0)

echo ""
echo "Import complete! Imported $count file(s)."
echo "Run 'calcurse' to view your calendar."
