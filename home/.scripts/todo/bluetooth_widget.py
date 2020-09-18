#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8

"""
Bluetooth widget using GTK+ and PyBluez.

Requires:
    PyGObject
    bluez-utils (bluetoothctl)

GTK tutorial:
https://python-gtk-3-tutorial.readthedocs.io/en/latest/gallery.html
"""

import subprocess
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk

bluetooth_process = subprocess.Popen(['bluetoothctl'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
def run_command(cmd: bytes):
    if type(cmd) == str:
        cmd = str.encode(cmd)
    while bluetooth_process.stdin.closed:
        continue
    bluetooth_process.stdin.write(cmd)
    stdout, stderr = bluetooth_process.communicate()
    print(bluetooth_process.returncode, stdout, stderr)
    return bluetooth_process.returncode, stdout, stderr
def close_bluetooth_process():
    res = run_command(b"quit")


def power_on():
    res = run_command("power on")
def scan_on():
    res = run_command("scan on")
def scan_off():
    res = run_command("scan off")

def get_device_info(mac_addr):
    info = run_command(f"info {mac_addr}")
    return info
def get_paired_devices():
    res = run_command("paired-devices")[1]
    res = res.split()
    devs = []
    n = 0
    while n != len(res):
        if res[n] == "Device":
            devs.append([res[n+1], res[n+2]])
            n += 2
        else:
            devs[-1][1] += " " + res[n]
        n += 1

    return devs
def get_pairable_devices():
    res = run_command("devices")[1]
    res = res.split()
    devs = []
    n = 0
    while n != len(res):
        # Skip nameless devices
        if res[n] == "Device" and res[n+2] == "Device":
            n += 1
        elif res[n] == "Device":
            devs.append([res[n+1], res[n+2]])
            n += 2
        else:
            devs[-1][1] += " " + res[n]
        n += 1

    # Remove already paired devices and devices that are not pairable
    n = 0
    while n != len(devs):
        info = get_device_info(devs[n][0])
        if "Paired: yes" in info:
            devs = devs[:n] + devs[n+1:]
        else:
            n += 1

    return devs
def is_connected(mac_addr):
    return "Connected: yes" in get_device_info(mac_addr)

def connect_device(mac_addr):
    run_command(f"connect {mac_addr}")
def disconnect_device(mac_addr):
    run_command(f"disconnect {mac_addr}")
def pair_device(mac_addr):
    run_command(f"pair {mac_addr}")
def trust_device(mac_addr):
    run_command(f"trust {mac_addr}")

class MyWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Hello World")
        self.set_role("float")

        # Modes: "connect" and "pair"
        self.mode = "connect"

        # Lists of widget references
        self.statuses = []

        # Panels
        self.main_box = Gtk.VBox(spacing=5)
        self.main_box.set_margin_start(5)
        self.main_box.set_margin_end(5)
        self.main_box.set_margin_top(5)
        self.main_box.set_margin_bottom(5)
        self.menu_box = Gtk.HBox(spacing=1)
        self.separator = Gtk.Separator()
        self.device_box = Gtk.VBox(spacing=1)

        self.add(self.main_box)
        self.main_box.add(self.menu_box)
        self.main_box.add(self.separator)
        self.main_box.add(self.device_box)

        # Add menu items
        self.refresh = Gtk.Button(label="󰑐")
        self.refresh.connect("clicked", self.refresh_devices)
        self.menu_box.add(self.refresh)

        self.pair = Gtk.Button(label="Pair")
        self.pair.connect("clicked", self.pair_menu)
        self.menu_box.add(self.pair)

        self.refresh_devices()

    def refresh_devices(self, _=None):
        """
        Refreshes all menu items based on bluetoothctl output
        """
        self.clear_devices()
        if self.mode == "connect":
            devs = get_paired_devices()
        else:
            devs = get_pairable_devices()
        for mac_addr, name in devs:
            self.add_device(mac_addr, name)

    def add_device(self, mac_addr, name):
        device_count = len(self.device_box.get_children())
        hbox = Gtk.HBox()
        butt = Gtk.Button(label=f"{name}\n{mac_addr}")
        butt.connect("clicked", self.device_click, mac_addr, device_count)
        if is_connected(mac_addr):
            status = Gtk.Label(label="󰂯")
        else:
            status = Gtk.Label(label="󰂲")
        hbox.add(status)
        hbox.add(butt)

        self.statuses.append(status)
        hbox.show_all()
        self.device_box.add(hbox)

    def device_click(self, _, mac_addr, index):
        if self.mode == "connect":
            if is_connected(mac_addr):
                #disconnect
                connect_device(mac_addr)
                self.statuses[index].set_label("󰂲")
            else:
                # connect
                disconnect_device(mac_addr)
                self.statuses[index].set_label("󰂯")
        else:
            pair_device(mac_addr)
            connect_device(mac_addr)
            trust_device(mac_addr)

    def clear_devices(self):
        self.statuses.clear()
        for d in self.device_box.get_children():
            self.device_box.remove(d)

    def pair_menu(self, _):
        if self.mode == "connect":
            self.mode = "pair"
            self.pair.set_label("󰌍")
            scan_on()
        else:
            self.mode = "connect"
            self.pair.set_label("Pair")
            scan_off()

        self.refresh_devices()

# Start bluetooth
power_on()

win = MyWindow()
win.connect("destroy", Gtk.main_quit)
win.show_all()
Gtk.main()

# Stop scanning after termination
scan_off()
