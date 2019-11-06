#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 rolfsievert <rolfsievert@manjaro>
#
# Distributed under terms of the MIT license.

"""

"""

import cv2
import sys
import numpy as np
import matplotlib.pyplot as plt

if __name__ == '__main__':
    img_paths = []
    if len(sys.argv) > 1:
        img_paths = sys.argv[1:]
    else:
        print("No images provided!!")

    cell_depth = 10

    fig = plt.figure()
    fig_cols = len(img_paths)

    for img_i, img_path in enumerate(img_paths):
        # Read image
        im = cv2.imread(img_path)

        # Create array with averages
        cells_avg = np.zeros((2**cell_depth, 2**cell_depth, 3))
        #print("Image shape: {}".format(im.shape))
        cell_w = im.shape[0] / 2.**cell_depth
        cell_h = im.shape[1] / 2.**cell_depth

        cells_avg = cv2.resize(im, (2**cell_depth, 2**cell_depth))

        # Draw colors
        fig.add_subplot(2, fig_cols, img_i+1)
        plt.imshow(cells_avg[:,:,::-1].astype(int))
        #plt.show()

        # Axes to project onto
        # Interpretation: (black to white), (green to red-blue), (red to green-blue), (blue to red-green)
        axes = np.array([[[0, 0, 0], [1, 1, 1]],
                         [[0, 1, 0], [1, -1, 1]],
                         [[1, 0, 0], [-1, 1, 1]],
                         [[1, 1, 0], [1, 1, -1]]])
        # Resulting colors
        res=[]

        # Loop over different pooling of cells
        for pool in range(0, cell_depth+1):
            if pool != 0:
                cells_avg = cv2.resize(cells_avg, (2**(cell_depth-pool), 2**(cell_depth-pool)))
            colordata=np.array(cells_avg.reshape((-1, 3)))
            # Find min and max values on all axes
            def myfunc(p, p1):
                print(p)
                p0, v = p1
                return np.linalg.norm(np.cross(v, p0-p))/np.linalg.norm(v)

            for [p0, v] in axes:
                projs = np.dot(colordata, v)
                # Add line distances?
                min_i = np.argmin(projs)
                max_i = np.argmax(projs)
                res.append(colordata[min_i])
                res.append(colordata[max_i])

        # Sort columns on brightness
        res = np.array(res)
        for col in range(res.shape[0]//8):
            srtd = sorted(res[col::8], key=lambda x: x.mean(), reverse=True)
            res[col::8] = np.array(srtd)
        res = res.reshape(-1, 8, 3)

        # Plot resulting data
        fig.add_subplot(2, fig_cols, len(img_paths)+img_i+1)
        plt.imshow(res[:,:,::-1].astype(int))

    # Color representations are:
    # Black White Green Purple Blue Orange Red Turquoise
    plt.show()

