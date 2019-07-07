#! /bin/sh

# Copies, enables, and starts services located in services folder

sudo true

if [ ! -d "~/.config/systemd/user" ]; then
    mkdir -p ~/.config/systemd/user
fi

for filename in $(dirname $0)/services/*.service; do
    # is user service
    if grep -q "WantedBy=default.target" "$(realpath $filename)"; then
        echo "Creating user service $(basename $filename .service)"
        sudo systemctl --user -f enable $(realpath $filename) --now
    else # system-wide service
        # Sevice name
        sudo systemctl enable "$(realpath $filename)" --now
    fi
    echo start
done
