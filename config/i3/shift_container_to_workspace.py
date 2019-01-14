#!/usr/bin/env python3

import i3ipc

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
command = "move container to workspace {}".format(int(focused.workspace().name) + 10)

i3.command(command)
