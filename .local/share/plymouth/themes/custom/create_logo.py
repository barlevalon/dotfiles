#!/usr/bin/env python3
from PIL import Image, ImageDraw

# Create a new image with transparent background
img = Image.new('RGBA', (800, 168), (0, 0, 0, 0))
draw = ImageDraw.Draw(img)

# Color for the text (same green as original)
color = (166, 218, 149, 255)  # #a6da95

# Pixel size (each "pixel" in our art will be this many actual pixels)
px = 10

# Starting position  
start_x = 65
start_y = 44

# Define each letter as a grid of blocks (1 = filled, 0 = empty)
# Each letter is designed to be clean and blocky like the original
letters_upper = {
    'H': [
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,1,1,1,1,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
    ],
    'E': [
        [1,1,1,1,1,1],
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [1,1,1,1,1,0],
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [1,1,1,1,1,1],
    ],
    'A': [
        [0,0,1,1,0,0],
        [0,1,0,0,1,0],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,1,1,1,1,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
    ],
    'R': [
        [1,1,1,1,1,0],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,1,1,1,1,0],
        [1,0,0,1,0,0],
        [1,0,0,0,1,0],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
    ],
    'T': [
        [1,1,1,1,1,1],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
        [0,0,1,1,0,0],
    ],
}

letters_lower = {
    'h': [
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [1,1,1,1,1,0],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
        [1,0,0,0,0,1],
    ],
    'e': [
        [0,0,0,0,0,0],
        [0,0,0,0,0,0],
        [0,1,1,1,1,0],
        [1,0,0,0,0,1],
        [1,1,1,1,1,1],
        [1,0,0,0,0,0],
        [1,0,0,0,0,0],
        [0,1,1,1,1,1],
    ],
    'a': [
        [0,0,0,0,0,0],
        [0,0,0,0,0,0],
        [0,1,1,1,1,0],
        [1,0,0,0,0,1],
        [0,0,0,0,0,1],
        [0,1,1,1,1,1],
        [1,0,0,0,0,1],
        [0,1,1,1,1,1],
    ],
    'r': [
        [0,0,0,0,0],
        [0,0,0,0,0],
        [1,0,1,1,0],
        [1,1,0,0,1],
        [1,0,0,0,0],
        [1,0,0,0,0],
        [1,0,0,0,0],
        [1,0,0,0,0],
    ],
    't': [
        [0,1,0,0],
        [0,1,0,0],
        [1,1,1,0],
        [0,1,0,0],
        [0,1,0,0],
        [0,1,0,0],
        [0,1,0,1],
        [0,0,1,0],
    ],
}

# Letter spacing
letter_spacing = 18
current_x = start_x

# Create uppercase version
word = 'HEARTER'
for char in word:
    if char in letters_upper:
        letter_data = letters_upper[char]
        for y, row in enumerate(letter_data):
            for x, pixel in enumerate(row):
                if pixel == 1:
                    # Draw a block
                    x1 = current_x + x * px
                    y1 = start_y + y * px
                    x2 = x1 + px
                    y2 = y1 + px
                    draw.rectangle([x1, y1, x2, y2], fill=color)
        
        # Move to next letter position
        current_x += len(letter_data[0]) * px + letter_spacing

# Save the uppercase image
img.save('logo_upper.png')
print("Created uppercase pixel art logo")

# Create lowercase version
img_lower = Image.new('RGBA', (800, 168), (0, 0, 0, 0))
draw_lower = ImageDraw.Draw(img_lower)
current_x = start_x

word = 'hearter'
for char in word:
    if char in letters_lower:
        letter_data = letters_lower[char]
        for y, row in enumerate(letter_data):
            for x, pixel in enumerate(row):
                if pixel == 1:
                    # Draw a block
                    x1 = current_x + x * px
                    y1 = start_y + y * px
                    x2 = x1 + px
                    y2 = y1 + px
                    draw_lower.rectangle([x1, y1, x2, y2], fill=color)
        
        # Move to next letter position
        current_x += len(letter_data[0]) * px + letter_spacing

# Save the lowercase image
img_lower.save('logo_lower.png')
print("Created lowercase pixel art logo")