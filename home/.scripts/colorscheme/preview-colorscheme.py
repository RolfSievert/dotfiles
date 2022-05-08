#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8

"""

"""

import i3ipc
import os
import subprocess
from pathlib import Path

i3 = i3ipc.Connection()

TERMINAL = "/usr/bin/alacritty"
EDITOR = "nvim"
SHELL = "/usr/bin/zsh"
PREVIEW_FILE = "colorscheme-preview.cpp"
I3_LAYOUT = "preview_i3_layout.json"

project_folder = Path(__file__).parent
i3_layout = project_folder / I3_LAYOUT
preview_file_path = project_folder / PREVIEW_FILE

# Open layout
focused = i3.get_tree().find_focused().workspace().name
command = ["i3-msg", "workspace " + focused + "; append_layout " + str(i3_layout.absolute())]

process = subprocess.Popen(command)
output, error = process.communicate()

# Run preview
command = [TERMINAL, "--class", "float", "--working-directory", project_folder,
           "-e",
           SHELL, "-ic",
           EDITOR + " " + str(preview_file_path.absolute())]
process = subprocess.Popen(command)

# output process id so that other applications can shutdown the preview
#print(process.pid)
with open(project_folder / "preview_colorscheme_pid.txt", 'w') as f:
    f.write(str(process.pid))

output, error = process.communicate()

def get_pid():
    with open(project_folder / "preview_colorscheme_pid.txt", 'r') as f:
        print(f.read())
