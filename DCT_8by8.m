function X = DCT_8by8(x)
% This function takes the 2D Discrete Cosine Transform of 8-by-8 images.

% Input: 'x' is the input image.

% Output: 'X' is the 2D DCT.

X = zeros(8,8);
for p = 0:7
    for q = 0:7
        for m = 0:7
            for n = 0:7
                % Correlate the input with various harmonics
                X(p+1,q+1) = X(p+1,q+1) + x(m+1,n+1) * cos(pi * (2*m+1) * p/16) * cos(pi * (2*n+1) * q/16);
            end
        end
    end
end

% Multiplying each component with proper scaling factor
coeff = 1/16 * ones(8,8) .* [1/2*ones(1,8); ones(7,8)] .* [1/2*ones(8,1) ones(8,7)];
X = X .* coeff;
end