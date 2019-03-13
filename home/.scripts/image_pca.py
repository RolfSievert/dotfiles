#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8

"""
This script creates a color palette from an image by finding the greatest principal components.
"""
import numpy as np
from PIL import Image

# Input image
im = Image.open("Media/Backgrounds/nordic-river.jpg")
# Resize image
im = im.resize((100, 100))
# Transform into array with numpy
pix = np.array(im)
# Center data
#pix = pix - np.mean(pix)
# Normalize data
pix = pix / np.abs(pix).max()

# Make list of rgb values
pix = pix.reshape(-1, 3)

# Calculate Eigenvectors
cov = np.cov(pix)
eigvals, eigvecs = np.linalg.eigh(cov)
print(eigvecs)

#U,S,V = linalg.svd(X)

# Extract the biggest PC and modify brightness / or sort by brightness

# Save color palette to json

# Send to wal?

# PCA - compact trick used
