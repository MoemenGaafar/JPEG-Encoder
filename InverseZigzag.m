function out = InverseZigzag(x)
% This function inverse-zigzag transforms the input into an 8-by-8 block.

% Input: 'x' is a 1D array.

% Output: 'out' is the output 2D 8-by-8 matrix.


% Initialize the output array
n = sqrt(size(x,2));
out = zeros(n,n);

% Populate the upper left half of the output matrix
k = 1;
for i = 1:n
    r = i;
    for j = 1:i
        % Ensure that the direction of traversal is reversal after each
        % diagonal
        if mod(i,2) == 0
            out(j,r) = x(k);
        else
           out(r,j) = x(k);
        end
        % Increment the column index and decrement the row index
        k = k + 1;
        r = r - 1;
    end
end

% Parameters required for the following traversal
k = n*n;
k_mod2 = mod(k,2);

% Populate the lower right half of the output matrix
for i = n:-1:2
    r = i;
    for j = n:-1:i
        % Ensure that the direction of traversal is reversal after each
        % diagonal
        if mod(i,2) == k_mod2
            out(r,j) = x(k);
        else
           out(j,r) = x(k);
        end
        % Increment the column index and decrement the row index
        k = k - 1;
        r = r + 1;
    end
end