import sys
from PIL import Image
import numpy as np

def usage():
    print("Usage: extract_spreadsheet.py <filename> <corner1x> <corner1y> <corner2x> <corner2y> <output>")

n = len(sys.argv)
if n != 6 and n != 7:
    usage()
    sys.exit(1)

if n == 6:
    output = "cropped.png"
else:
    output = sys.argv[6]
filename = sys.argv[1]
corner1 = (int(sys.argv[2]), int(sys.argv[3]))
corner2 = (int(sys.argv[4]), int(sys.argv[5]))

# extract rectangle from spreadsheet
im = Image.open(filename)
im = im.crop((corner1[0], corner1[1], corner2[0], corner2[1]))
im.save(output)