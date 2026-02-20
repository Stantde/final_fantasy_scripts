'''
Reads FILENAME and prints properties.
'''
from PIL import Image
FILENAME = "Screenshot 2026-02-17 155542.png" # 3980 x 1080
im = Image.open(FILENAME)
print(im.format, im.size, im.mode)