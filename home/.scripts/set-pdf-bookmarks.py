#! /usr/bin/env python3
# -*- coding: utf-8 -*-
# vim:fenc=utf-8

import argparse
from PyPDF2 import PdfFileReader, PdfFileWriter
import pathlib

index_example = \
"""
1 Introduction
  2 Background
    3 Extra
  4 Theory

8 Appendix
"""

parser = argparse.ArgumentParser(description=f'Set bookmarks to a pdf according to index file. Index entries start with page number followed by bookmark name, where children are defined with spaces.')
parser.add_argument('pdf_path', type=pathlib.Path, help='path to the pdf')
parser.add_argument('-i', required=True, type=pathlib.Path, help='path to file containing indexes of bookmarks')
parser.add_argument('-o', required=True, type=pathlib.Path, help='output path of new pdf')

args = parser.parse_args()

writer = PdfFileWriter()
reader = PdfFileReader(args.pdf_path)
writer.clone_document_from_reader(reader)

with open(args.i, 'r') as index:
    parent_bookmarks = []
    for line in index:
        if not line.isspace():
            page_number, bookmark_title = line.strip().split(' ', 1)
            page_number = int(page_number) - 1
            leading_spaces = len(line) - len(line.lstrip()) # counts all whitespaces

            # remove all non-parents before in stack
            while len(parent_bookmarks) > 0 and leading_spaces <= parent_bookmarks[-1][0]:
                parent_bookmarks = parent_bookmarks[:-1]

            if not len(parent_bookmarks):
                bookmark = writer.add_outline_item(bookmark_title, page_number, parent=None)
            else:
                parent = parent_bookmarks[-1][1]
                bookmark = writer.add_outline_item(bookmark_title, page_number, parent=parent)

            parent_bookmarks.append((leading_spaces, bookmark))

writer.page_mode = "/UseOutlines" # This is what tells the PDF to open to bookmarks

with open(args.o, "wb") as f:
    writer.write(f)
