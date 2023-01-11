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

download_count = 0

print()
for i, image in enumerate(images):
    print(f"Downloading... ({len(downloads) + i}/{db_length})", end='\r', flush=True)

    import requests
    resp = requests.get(unsplash_download_url.format(image))

    if resp.status_code != 200:
        print(f'Skipping image with id "{image}". Not found or no internet connection.')
    else:
        try:
            from PIL import Image
            from io import BytesIO
            img = Image.open(BytesIO(resp.content))
            with open(f'{BACKGROUNDS_PATH}/{image}-unsplash.jpg', 'wb') as f:
                img.save(f)
        except e:
            print(f'Failed to save image from respone {response}!')
            throw(e)

print(f'Done. Downloaded {download_count} / {len(images)} images.')

