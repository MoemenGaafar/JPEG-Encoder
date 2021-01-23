clear; clc;
% x = [42 28 35 28 42 49 35 1;
%      49 49 35 28 35 35 2 42;
%      42 21 21 28 42 3 42 28;
%      21 35 35 42 42 28 28 14;
%      56 70 77 84 91 28 28 21;
%      70 126 133 147 161 91 35 14;
%      126 203 189 182 175 175 35 21;
%      49 189 245 210 182 84 21 3];
%  
% y = reshape(64:-1:1,8,8)';
% X = DCT_8by8(x);
% Quantize(y,"high");
% t = RunlengthEncode([0 0 1 0 4 0 0 0 6]);
% RunlengthDecode(t);
% ZeroPad([1 2 3], 8);
% 
% M = [1 2 3; 4 5 6; 7 8 9];
% z = Zigzag(y);
% InverseZigzag(z);
% symbols = 1:6; 
% p = [.5 .125 .125 .125 .0625 .0625];
% dict = huffmandict(symbols,p);
% inputSig = randsrc(100,1,[symbols;p]);
% code = huffmanenco(inputSig,dict);
% sig = huffmandeco(code,dict);
% isequal(inputSig,sig)
%X = DCT_8by8(x)
%x_back = IDCT_8by8(X)


x = rgb2gray(imread("peppers.png"));
figure(2)
imshow(x)
[m_org, n_org] = size(x);

% Encoder starts here
x = ZeroPad(double(x), 8);
n = size(x,1);
X = [];
for i = 1:n/8
    for j = 1:n/8
      x_8by8 = x((i-1)*8+1 : i*8, (j-1)*8+1 : j*8);
      x_DCT = DCT_8by8(x_8by8);
      x_Quantized = Quantize(x_DCT, "high");
      x_Zigzaged = Zigzag(x_Quantized);
      X = [X x_Zigzaged];
    end
end
x_encoded = RunlengthEncode(X);
characters = unique(x_encoded);
probs = GetProbabilities(x_encoded, characters);
code = HuffmanCreator(characters, probs);
x_Huffman_en = HuffmanEncoder(characters, code, x_encoded);

% Decoder starts here
x_Huffman_de = HuffmanDecoder(characters, code, x_Huffman_en);
x_decoded = RunlengthDecode(x_Huffman_de);
Output = zeros(n,n);
for i = 1:n/8
    for j = 1:n/8
      x = x_decoded((i-1)*8*n+(j-1)*64+1 : (i-1)*8*n+j*64);
      x_block = InverseZigzag(x);
      x_dequantized = InverseQuantize(x_block, "high");
      x_IDCT = IDCT_8by8(x_dequantized);
      Output((i-1)*8+1 : i*8, (j-1)*8+1 : j*8) = x_IDCT;
    end
end
Output = Output(1:m_org,1:n_org);

figure(1)
imshow(uint8(Output));
