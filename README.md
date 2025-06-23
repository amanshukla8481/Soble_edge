 

# Sobel Edge Detection using Verilog and Python

This project implements a **Sobel Edge Detection** algorithm on images by combining **Python for image preprocessing** and **Verilog for core hardware implementation**.

## 🛠️ Project Structure

```
soble_edge/
├── sobel_edge.v         # Verilog module for Sobel edge detection
├── image_to_txt.py      # Python script to convert image to .txt pixel data
├── txt_to_image.py      # Python script to convert .txt back to image format
├── input.txt            # Intermediate file containing pixel values
├── output.txt           # Output edge-detected pixel values
└── README.md            # Project documentation
```

## 📸 Overview

* The image is first converted to grayscale pixel values using Python.
* These pixel values are saved into a `.txt` file.
* The Verilog module reads these values, applies the Sobel filter, and generates edge data.
* The processed output is saved back as `.txt`, which is converted to an image using Python again.

## ✅ Solved Issues

### 1. **Unmatched Pixel Dimensions**

* **Problem**: The output image had fewer pixels than the original due to the Sobel kernel needing valid neighboring pixels.
* **Solution**: **Zero-padding** was added to ensure the filter could be applied on all relevant pixels, especially at the borders.

### 2. **Image Aliasing**

* **Problem**: Output images showed harsh artifacts and edge breaks.
* **Solution**: Padding and clamping values helped reduce high-frequency noise and aliasing.

---

## 🚀 How to Run

### 1. Convert Image to Text

```bash
python image_to_txt.py
```

### 2. Simulate Verilog Module

Use any Verilog simulator (like ModelSim, Vivado, etc.) to run `sobel_edge.v` with `input.txt` as input and generate `output.txt`.

### 3. Convert Output to Image

```bash
python txt_to_image.py
```

---

## 📌 Requirements

* Python 3.x
* PIL (`pip install Pillow`)
* NumPy
* Verilog simulation tools (Icarus Verilog, ModelSim, etc.)

---

## 📷 Example

**Original Image → Sobel Processed Image**

*(You can update this section with actual input/output samples)*

---

## 💡 Notes

* The kernel used is the standard 3x3 Sobel operator.
* This design is meant to test Verilog-based image processing logic for FPGA or hardware acceleration experiments.
* Padding was added by Python before writing to `.txt`.
