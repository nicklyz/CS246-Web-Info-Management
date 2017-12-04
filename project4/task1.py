#!/usr/bin/env python3

import sys
import os
import numpy
import numpy.linalg
import scipy.misc

def getOutputPngName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.png'

def getOutputNpyName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.npy'

if len(sys.argv) < 3:
    sys.exit('usage: task1.py <PNG inputFile> <rank>')

inputfile = sys.argv[1]
rank = int(sys.argv[2])
outputpng = getOutputPngName(inputfile, rank)
outputnpy = getOutputNpyName(inputfile, rank)

# Load image
image = scipy.misc.imread(inputfile)

# singular value decomposition
u, s, v = numpy.linalg.svd(image)

# rank-k approximation
result = numpy.zeros(image.shape)
for i in range(rank):
    result += s[i] * numpy.outer(u.T[i], v[i])

numpy.save(outputnpy, arr=result)
scipy.misc.imsave(outputpng, arr=result)
print("Rank-k approximation images saved!")
