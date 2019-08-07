#! /usr/bin/env python
# -*- coding: utf-8 -*-

"""
Opens a layout in specified folder
"""
import i3ipc
import sys
import os
import subprocess

i3 = i3ipc.Connection()

TERMINAL = "gnome-terminal"
focused = i3.get_tree().find_focused().workspace().name

# Check number of arguments
if len(sys.argv) != 2:
    print("ERROR!")
    print("Exactly ONE folder must be specified in script call.")
    exit(1)

project_folder = sys.argv[1]
local_folder = os.path.dirname(os.path.realpath(sys.argv[0]))
layout_path = local_folder + "/project-layout.json"
command = ["i3-msg", "workspace " + focused + "; append_layout " + layout_path]
# Load layout
process = subprocess.Popen(command, stdout=subprocess.PIPE)
output, error = process.communicate()

# Run terminals
process = subprocess.Popen([TERMINAL, "--working-directory", project_folder, "--", "nvim"], stdout=subprocess.PIPE)
output, error = process.communicate()
process = subprocess.Popen([TERMINAL, "--working-directory", project_folder, "--", "nvim"], stdout=subprocess.PIPE)
output, error = process.communicate()
process = subprocess.Popen([TERMINAL, "--working-directory", project_folder], stdout=subprocess.PIPE)
output, error = process.communicate()
