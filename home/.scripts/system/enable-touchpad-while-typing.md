
# Enable touchpad while typing

* Find your touchpad device by running `xinput list`
* Find the property to disable/enable: `xinput list-props <ID of touchpad>`
    In my case it's "libinput Disable While Typing Enabled" (skip the parenthesis with a number)
* Then lastly: `xinput set-prop "name of your touchpad" "libinput Disable While Typing Enabled" 1`

Note: There is an option called "libinput Disable While Typing Enabled Default", but access to this property seems to be restricted.
