function [X, HuffmanCodes] = JPEG_Encoder(x, compression)
% This is the JPEG Encoder function.

% Inputs: 'x' is the input grayscale image and 'compression' is a flag to 
% specify the compression rate desired.

% Outputs: 'X' is the compressed and encoded stream of bits that represent
% the image and 'HuffmanCodes' are the Huffman codes required to decode the
% stream into characters.


% First check the validity of the flag and encode it into one character to
% be sent as a header to the decoder
if strcmp(compression, "high")
    QuantHeader = 1;
elseif strcmp(compression, "low")
    QuantHeader = 2;
elseif strcmp(compression, "standard")
    QuantHeader = 3;
else
    disp("Compression parameter can either be 'high', 'low' or 'standard'.");
    return;
end

% If the image is RGB, convert it to grayscale
if length(size(x)) > 2
    x = rgb2gray(x);
end

% Show the grayscale image before compression
imshow(x)

% Store the original dimensions of the image to be sent as headers
[m_org, n_org] = size(x);

% Zero pad the image to ensure that both dimensions are a multiple of 8 and
% that they are both equal
x = ZeroPad(double(x), 8);

n = size(x,1);
x_1D = [];

for i = 1:n/8
    for j = 1:n/8
      % Divide the image into blocks of 8 by 8 pixels
      x_8by8 = x((i-1)*8+1 : i*8, (j-1)*8+1 : j*8);
      % Apply DCT to each block
      x_DCT = DCT_8by8(x_8by8);
      % Quantize the DCT according to the input compression rate
      x_Quantized = Quantize(x_DCT, QuantHeader);
      % Zigzag traverse each block and transform it into a 1D array
      x_Zigzaged = Zigzag(x_Quantized);
      % Concatenate all the 1D arrays into a long stream
      x_1D = [x_1D x_Zigzaged];
    end
end

% Collect all headers in one array and add it to the stream to be encoded
headers = [QuantHeader m_org n_org];
x_1D = [headers x_1D];

% Apply run-length encoding
x_runlength_en = RunlengthEncode(x_1D);

% Apply Huffman encoding
characters = unique(x_runlength_en);
probs = GetProbabilities(x_runlength_en, characters);
code = HuffmanCreator(characters, probs);
X = HuffmanEncoder(characters, code, x_runlength_en);
HuffmanCodes = cell(1,2);
HuffmanCodes{1} = characters;
HuffmanCodes{2} = code;
end