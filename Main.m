clear; clc;
x_input = imread("peppers.png");
[X, HuffmanCodes] = JPEG_Encoder(x_input, "standard");
x_output = JPEG_Decoder(X, HuffmanCodes);
ssim(rgb2gray(x_input),x_output)