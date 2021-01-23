function Q = Quantize(x, QuantHeader)
% This function quantizes the input 8-by-8 DCT using a certain quantization
% table.

% Inputs: 'x' is the input 8-by-8 DCT to be quantized and 'QuantHeader' is
% a flag to specify the type of compression.

% Output: 'Q' is the quantized DCT.


% Define the quantization tables
high = [1 2 4 8 16 32 64 128;
        2 4 4 8 16 32 64 128;
        4 4 8 16 32 64 128 128;
        8 8 16 32 64 128 128 256;
        16 16 32 64 128 128 256 256;
        32 32 64 128 128 256 256 256;
        64 64 128 128 256 256 256 256;
        128 128 128 256 256 256 256 256];   
    
low = [1 1 1 1 1 2 2 4;
       1 1 1 1 1 2 2 4;
       1 1 1 1 2 2 2 4;
       1 1 1 1 2 2 4 8;
       1 1 2 2 2 2 4 8;
       2 2 2 2 2 4 8 8;
       2 2 2 4 4 8 8 16;
       4 4 4 4 8 8 16 16];

standard = [16 11 10 16 24 40 51 61;
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56;
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 36 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];

% Divide the input by the proper quantization table and round the output
% to the nearest integer
if QuantHeader == 1
    Q = round(x ./ high);
elseif QuantHeader == 2
    Q = round(x ./ low);
else
    Q = round(x ./ standard);
end