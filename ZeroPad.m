function Z = ZeroPad(x, dim)
% This function zero pads an image to match certain dimensions.

% Inputs: 'x' is the image to be zero padded and 'dim' is the desired image
% dimension.

% Output: 'Z' is the padded image.

% Find out which dimension is larger to pad the other to match it
[n,m] = size(x);
if n > m
    larger = n;
else
    larger = m;
end

% Calculate the desired image dimensions
required = dim * ceil(larger/dim);

% Pad the x-dimension
if required > m
    rem_x = required - m;
    x = [x zeros(n,rem_x)];
    m = m + rem_x;
end

% Pad the y-dimension
if required > n
    rem_y = required - n;
    x = [x; zeros(rem_y, m)];
end

Z = x;
end