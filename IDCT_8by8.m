function X = IDCT_8by8(x)
% This function takes the 2D Inverse Discrete Cosine Transform of 8-by-8 blocks.

% Input: 'x' is the input DCT.

% Output: 'X' is the 2D image.

X = zeros(8,8);
for p = 0:7
    for q = 0:7
        for m = 0:7
            for n = 0:7
                % Scale each harmonic with its corresponding amplitude
                X(p+1,q+1) = X(p+1,q+1) + x(m+1,n+1) * cos(pi/16 * (2*p+1) * m) * cos(pi/16 * (2*q+1) * n);
            end
        end
    end
end
end