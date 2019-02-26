#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 hitsnapper <hitsnapper@Znap>
#
# Distributed under terms of the MIT license.

"""

"""

import json
import os
from random import *

# choose dataset

set_nr = randint(0, 2)
data = []
dataset_path = os.path.dirname(os.path.realpath(__file__)) + '/joke-dataset/'

# Load data
if set_nr == 0:
    with open(dataset_path + 'wocka.json') as f:
        data = json.load(f)
elif set_nr == 1:
    with open(dataset_path + 'reddit_jokes.json') as f:
        data = json.load(f)
elif set_nr == 2:
    with open(dataset_path + 'stupidstuff.json') as f:
        data = json.load(f)

# Print message
# Debugging
index = randint(0, len(data)-1)
if set_nr == 0:
    print(data[index]["title"])
    print(data[index]["body"])

elif set_nr == 1:
    print(data[index]["title"])
    print(data[index]["body"])

elif set_nr == 2:
    print(data[index]["body"])
