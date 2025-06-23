import cv2
import numpy as np

# Load and resize image
image = cv2.imread("logo.jpg", cv2.IMREAD_GRAYSCALE)
image = cv2.resize(image, (256, 256))

# Zero-pad the image to handle edges
padded_image = np.pad(image, pad_width=1, mode='constant', constant_values=0)

output_lines = []

# Loop through every pixel in the original image
for y in range(1, 257):  # from 1 to 256 inclusive
    for x in range(1, 257):
        # 3x3 neighborhood around each original pixel
        neighborhood = padded_image[y-1:y+2, x-1:x+2]
        hex_values = [f"{pixel:02X}" for row in neighborhood for pixel in row]
        output_lines.append(" ".join(hex_values))

# Save to input.txt
with open("input.txt", "w") as f:
    f.write("\n".join(output_lines))

print(f"✅ Done! Total lines written: {len(output_lines)} (should be 256×256 = 65536)")
