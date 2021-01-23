function x = JPEG_Decoder(X, HuffmanCodes)
% This is the JPEG Decoder function.

% Inputs: 'X' is the compressed and encoded stream of bits that represent
% the image and 'HuffmanCodes' are the Huffman codes required to decode the
% stream into characters.

% Outputs: 'x' is the compressed image.


% Apply Huffman decoding
characters = HuffmanCodes{1};
code = HuffmanCodes{2};
x_Huffman_de = HuffmanDecoder(characters, code, X);

% Apply run-length decoding
x_decoded = RunlengthDecode(x_Huffman_de);

% Extract the headers
QuantHeader = x_decoded(1);
m_org = x_decoded(2);
n_org = x_decoded(3);
x_decoded = x_decoded(4:end);

% Deduce the dimensions of the zero padded image
if n_org > m_org
    larger = n_org;
else
    larger = m_org;
end
n = 8 * ceil(larger/8);

x = zeros(n,n);
for i = 1:n/8
    for j = 1:n/8
      % Divide the stream of characters into arrays of 64 elements
      x_1D = x_decoded((i-1)*8*n+(j-1)*64+1 : (i-1)*8*n+j*64);
      % Convert the 1D array into a 2D 8-by-8 block
      x_block = InverseZigzag(x_1D);
      % Rescale the DCT using the same quantization table
      x_dequantized = InverseQuantize(x_block, QuantHeader);
      % Apply IDCT to retrieve the image block
      x_IDCT = IDCT_8by8(x_dequantized);
      % Concatenate all the 8-by-8 blocks into the image
      x((i-1)*8+1 : i*8, (j-1)*8+1 : j*8) = x_IDCT;
    end
end

% Crop the zero padding using the original dimensions
x = uint8(x(1:m_org,1:n_org));

% Show the compressed image
imshow(x)
end