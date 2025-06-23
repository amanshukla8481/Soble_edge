import cv2
import numpy as np

# Load raw data
with open("output.txt", "r") as file:
    data = file.read()

pixel_values = []
for val in data.strip().split():
    try:
        number = int(val)
        if 0 <= number <= 255:
            pixel_values.append(number)
    except ValueError:
        continue  # Skip invalid entries like 'X'

# Set target image width
image_width = 256

# Calculate required height (ceil)
import math
total_pixels = len(pixel_values)
# image_height = math.ceil(total_pixels / image_width)
#expected_total = image_height * image_width
image_height = 256
expected_total = image_height * image_width

# Pad with zeros if needed
pixel_values += [0] * (expected_total - total_pixels)

# Reshape and save
image_array = np.array(pixel_values, dtype=np.uint8).reshape((image_height, image_width))

cv2.imwrite("dxy_padded_image.png", image_array)
cv2.imshow("Restored Image", image_array)
cv2.waitKey(0)
cv2.destroyAllWindows()
