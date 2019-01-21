#!/usr/bin/env python3

import i3ipc

# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = i3ipc.Connection()

workspaces=i3.get_workspaces()
focused=0
# Move workspaces up 10 adn save focused window number
for container in reversed(workspaces):
    ws_num = int(container.name)
    if container.focused:
        focused=ws_num
    print("Workspace: {}".format(ws_num))  
    command = "rename workspace {} to {}".format(ws_num, ws_num + 10)
    print("Command: " + command)
    i3.command(command)

# Move down the workspaces that got to far up
workspaces=i3.get_workspaces()
for container in [x for x in workspaces if int(x.name) > 20]:
    ws_num = int(container.name)
    print("Workspace: {}".format(ws_num))  
    command = "rename workspace {} to {}".format(
            ws_num, ws_num % 10)
    print("Command: " + command)
    i3.command(command)

# Change focus to new workspaces
i3.command("workspace {}".format(focused))
