#!/bin/bash

# Initialize gamma values
i=1.0
j=1.0
k=1.0

# Function to reset gamma values
reset_gamma() {
    xrandr --output eDP --gamma 1:1:1
    exit 0
}

# Trap signals (SIGINT and SIGTERM)
trap reset_gamma SIGINT SIGTERM

# Start with i
active="i"

while true
do
    # Set the gamma values
    xrandr --output eDP --gamma $k:$j:$i

    # Increment the currently active value
    if [ "$active" == "i" ]; then
        i=$(echo "$i + 1" | bc)
        if (( $(echo "$i >= 20" | bc -l) )); then
            i=1.0  # Reset i to 1
            active="j"  # Move to the next variable
        fi
    elif [ "$active" == "j" ]; then
        j=$(echo "$j + 1" | bc)
        if (( $(echo "$j >= 20" | bc -l) )); then
            j=1.0  # Reset j to 1
            active="k"  # Move to the next variable
        fi
    elif [ "$active" == "k" ]; then
        k=$(echo "$k + 1" | bc)
        if (( $(echo "$k >= 20" | bc -l) )); then
            k=1.0  # Reset k to 1
            active="i"  # Go back to i
        fi
    fi

    # Sleep for a short duration
    sleep 0.0005
done

