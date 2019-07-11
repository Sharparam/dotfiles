#!/usr/bin/env python3

# pylint: disable=C0103

import sys
from scipy import absolute, fftpack
import skimage
import imageio

scale = 5.

image = imageio.imread(sys.argv[1])
image = skimage.transform.rescale(
        skimage.color.rgba2rgb(image), 1./scale, anti_aliasing=False, multichannel=True
        )
fft = fftpack.fftn(image)
fshift = fftpack.fftshift(fft)

rows = len(fft)
cols = len(fft[0])
red_const = int(3*cols/4)

crow = rows/2
ccol = cols/2

upper_boundary = int(crow - rows / red_const)
lower_boundary = int(crow + rows / red_const)
left_boundary = int(ccol - cols / red_const)
right_boundary = int(ccol + cols / red_const)

fshift[:upper_boundary, :left_boundary] = 0
fshift[:upper_boundary, right_boundary:] = 0
fshift[lower_boundary:, right_boundary:] = 0
fshift[lower_boundary:, :left_boundary] = 0

f_ishift = fftpack.ifftshift(fshift)
img_back = fftpack.ifftn(f_ishift)
img_back = absolute(img_back)

img_back = skimage.transform.rescale(
        img_back, scale, anti_aliasing=False, multichannel=True, order=0
        )

result = imageio.imwrite(sys.argv[2], img_back)
