#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.

"""
Creates a colorscheme in json format from base16 colorscheme.
"""

import yaml
import json
import sys
import os

for arg in sys.argv[1:]:
    dir_path, file = os.path.split(arg)
    file_name, file_ext = os.path.splitext(file)
    if file_ext == ".yaml" or file_ext == ".yml":
        with open(arg, 'r') as stream:
            try:
                yaml_data=yaml.safe_load(stream)
            except yaml.YAMLError as exc:
                print(exc)
        #print(yaml_data)
        x = {
            "name": yaml_data['scheme'],
            "author": yaml_data['author'],
            "special": {
                "background": '#'+yaml_data['base00'],
                "foreground": '#'+yaml_data['base05'],
                "cursor": '#'+yaml_data['base05']
            },
            "colors": {
                'color0': '#'+yaml_data['base00'],
                'color1': '#'+yaml_data['base08'],
                'color2': '#'+yaml_data['base0B'],
                'color3': '#'+yaml_data['base0A'],
                'color4': '#'+yaml_data['base0D'],
                'color5': '#'+yaml_data['base0E'],
                'color6': '#'+yaml_data['base0C'],
                'color7': '#'+yaml_data['base05'],
                'color8': '#'+yaml_data['base03'],
                'color9': '#'+yaml_data['base00'],
                'color10': '#'+yaml_data['base0B'],
                'color11': '#'+yaml_data['base0A'],
                'color12': '#'+yaml_data['base0D'],
                'color13': '#'+yaml_data['base0E'],
                'color14': '#'+yaml_data['base0C'],
                'color15': '#'+yaml_data['base07']
            }
        }
        #print(json.dumps(x))

        with open(os.path.join(dir_path, file_name) + '.json', 'w', encoding='utf-8') as f:
            json.dump(x, f, ensure_ascii=False, indent=4)
    else:
        print(arg + " is not of type .yaml")
