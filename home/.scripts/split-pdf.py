#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8

import argparse
from PyPDF2 import PdfFileReader, PdfFileWriter
import pathlib
from copy import deepcopy

index_example = \
"""
Name of new pdf
  2-202

Second pdf name
  100-200
  150-300
"""

parser = argparse.ArgumentParser(description=f'Set bookmarks to a pdf according to index file. Index entries start with page number followed by bookmark name, where children are defined with spaces.')
parser.add_argument('pdf_path', type=pathlib.Path, help='path to the pdf')
parser.add_argument('-r', required=True, type=pathlib.Path, help='path to file containing ranges')

args = parser.parse_args()

reader = PdfFileReader(args.pdf_path)

def addOutlines(writer, outlines, old_to_new_page_map, parent):
    while len(outlines):
        ol = outlines.pop(0)
        new_parent = None
        if len(outlines) and type(ol) is not list and type(outlines[0]) is list and ol.page in old_to_new_page_map.keys():
            new_parent = writer.add_outline_item(title=ol.title, pagenum=old_to_new_page_map[ol.page], parent=parent)
            ol = outlines.pop(0)

        if type(ol) is list:
            addOutlines(writer, ol, old_to_new_page_map, new_parent)
        elif ol.page in old_to_new_page_map.keys():
            writer.add_outline_item(title=ol.title, pagenum=old_to_new_page_map[ol.page], parent=parent)

def writePdf(writer, pdf_name, old_to_new_page_map):
    addOutlines(writer, deepcopy(reader.outline), old_to_new_page_map, parent=None)

    writer.page_mode = "/UseOutlines" # This is what tells the PDF to open to bookmarks
    pdf_name += '.pdf'
    print(f"Saving '{pdf_name}'...\n")
    with open(pdf_name, "wb") as f:
        writer.write(f)


with open(args.r, 'r') as index:
    pdf_name = ''
    writer = PdfFileWriter()
    old_to_new_page_map = {}
    page = 0

    for line in index:
        title = line.strip()
        range_split = line.strip().split('-')

        if len(range_split) == 2 and range_split[0].isdigit() and range_split[1].isdigit():
            print(f"Adding range {range_split} to '{pdf_name}'...")
            # add range to pdf
            start = int(range_split[0]) - 1
            end = int(range_split[1])

            for page_num in range(start, end):
                old_to_new_page_map[page_num] = page
                page = page + 1

            for page_num in range(start, end):
                writer.add_page(reader.pages[page_num])

        elif title != '':
            # save previous pdf range
            if not pdf_name.isspace() and pdf_name != '':
                writePdf(writer, pdf_name, old_to_new_page_map)
            # assign new pdf
            writer = PdfFileWriter()
            old_to_new_page_map = {}
            page = 0
            pdf_name = title

    # save last pdf
    if not pdf_name.isspace() and pdf_name != '':
        writePdf(writer, pdf_name, old_to_new_page_map)

print("Done.")
