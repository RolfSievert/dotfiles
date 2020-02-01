#! /bin/sh

# Copies, enables, and starts services located in services folder

sudo true

# Create dir if nonexisting
if [ ! -d "~/.config/systemd/user" ]; then
    mkdir -p ~/.config/systemd/user
fi

for filename in $(dirname $0)/services/*.service; do
    # is user service
    if grep -q "WantedBy=default.target" "$(realpath $filename)"; then
        echo "Creating user service $(basename $filename .service)"
        # Create user service, overwrite if existing, and start the service now
        echo $(realpath $filename)
        sudo systemctl --user -f enable $(realpath $filename) --now
    else # system-wide service
        # Sevice name
        sudo systemctl enable -f "$(realpath $filename)" --now
    fi
    echo start
done
