#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2020 znap <znap@asusmanjaro>
#
# Distributed under terms of the MIT license.

"""
Downloads images with provided json-database with image IDs from unsplash.
"""

import argparse

parser = argparse.ArgumentParser(description='Downloads files specified in json-database to directory.')
parser.add_argument(dest="directory", type=str, help='path to directory containing images')
parser.add_argument(dest="database", type=str, help='path to json file')

args = parser.parse_args()

BACKGROUNDS_PATH=args.directory
DATABASE_PATH=args.database


import os
def listDownloads():
    res=[]
    for filename in os.listdir(BACKGROUNDS_PATH):
        end_index = filename.find("-unsplash.jpg")
        if end_index != -1:
            image_id = filename[:end_index][-11:]
            res.append(image_id)
    return res


# Image url for download:
# https://unsplash.com/photos/[id]/download
unsplash_download_url="https://unsplash.com/photos/{}/download"
# if just viewing the page, remove '/download'

import json
with open(DATABASE_PATH, 'r') as f:
    images = json.load(f)

db_length=len(images)
downloads=listDownloads()
images=[x for x in images if x not in downloads]

import urllib.request as request
import sys
print()
for i, image in enumerate(images):
    #sys.stdout.flush()
    #print("\r")
    #sys.stdout.flush()
    print(f"Downloading... ({len(downloads) + i}/{db_length})", end='\r')
    resp = request.urlopen(unsplash_download_url.format(image))
    try:
        with open(f'{BACKGROUNDS_PATH}/{image}-unsplash.jpg', 'wb') as handler:
            handler.write(resp.read())
    except:
        print(f"Aborted. Downloaded {i} images.")
        raise

print(f"Done. Downloaded {len(images)} images.")

