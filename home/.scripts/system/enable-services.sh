#! /bin/sh

# Copies, enables, and starts services located in services folder

sudo true

# Create dir if nonexisting
if [ ! -d "~/.config/systemd/user" ]; then
    mkdir -p ~/.config/systemd/user
fi

for filename in $(dirname $0)/services/*.service; do
    # is user service
    echo 
    if grep -q "WantedBy=default.target" "$(realpath $filename)"; then
        echo Creating user service: "$filename"
        # Create user service, overwrite if existing, and start the service now
        # TODO should launch user config instead of system
        #cp -f "$filename" ~/.config/systemd/user/
        #sudo systemctl --user enable -f $filename --now

        sudo systemctl enable -f "$(realpath $filename)" --now
    else # system-wide service
        echo Creating system-wide service: "$filename"
        # Sevice name
        sudo systemctl enable -f "$(realpath $filename)" --now
    fi
done

echo
echo DONE launching services.
