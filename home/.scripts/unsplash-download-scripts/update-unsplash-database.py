#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 znap <znap@asusmanjaro>
#
# Distributed under terms of the MIT license.

"""
Maintainer for local unsplash database.
Searches /Backgrounds folder for unsplash images and updates .json database from found images.
"""

import os
import argparse

parser = argparse.ArgumentParser(description='Updates json-database based on unsplash images in provided folder.')
parser.add_argument(dest="directory", type=str, help='path to directory containing images')
parser.add_argument(dest="database", type=str, help='path to json file')

args = parser.parse_args()

BACKGROUNDS_PATH=args.directory
DATABASE_PATH=args.database
#DATABASE_PATH="unsplash-images.json"
#BACKGROUNDS_PATH="./Backgrounds"
def listDownloads():
    res=[]
    for filename in os.listdir(BACKGROUNDS_PATH):
        end_index = filename.find("-unsplash.jpg")
        if end_index != -1:
            image_id = filename[:end_index][-11:]
            res.append(image_id)
    return res

if __name__ == "__main__":
    images=listDownloads()

    # loop through backgrounds folder and find all unsplash image IDs

    import json
    with open(DATABASE_PATH, 'w', encoding='utf-8') as f:
        json.dump(images, f, ensure_ascii=False, indent=4)

    print(f"Wrote {len(images)} images IDs to './{DATABASE_PATH}'.")
