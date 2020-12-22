#! /bin/sh

# Copies, enables, and starts services located in services folder

sudo true

# Create dir if nonexisting
if [ ! -d "~/.config/systemd/user" ]; then
    mkdir -p ~/.config/systemd/user
fi

for filename in $(dirname $0)/services/user/*.service; do
    # is user service
    echo 
    echo Creating user service: "$filename"
    # Create user service, overwrite if existing, and start the service now
    echo "$filename"
    echo $(basename -- "$filename")
    cp -f "$filename" ~/.config/systemd/user/
    systemctl --user enable -f $(basename -- "$filename")

    #sudo systemctl enable -f "$(realpath $filename)" --now
done

# system-wide service
for filename in $(dirname $0)/services/system/*.service; do
    echo
    echo Creating system-wide service: "$filename"
    # Sevice name
    sudo systemctl enable -f "$(realpath $filename)" --now
done

echo
echo DONE launching services.
