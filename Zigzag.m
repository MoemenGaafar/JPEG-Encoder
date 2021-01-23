function out = Zigzag(x)
% This function zigzag traverses the input into a 1D stream.

% Input: 'x' is the input 2D matrix to be zigzad traversed.

% Output: 'out' is a 1D array of the output of traversal.


% Initialize the output array
n = size(x,1);
out = zeros(1,n*n);

% Traverse the upper left half of the input matrix
k = 1;
for i = 1:n
    r = i;
    for j = 1:i
        % Ensure that the direction of traversal is reversal after each
        % diagonal
        if mod(i,2) == 0
            out(k) = x(j,r);
        else
           out(k) = x(r,j);
        end
        % Increment the column index and decrement the row index
        k = k + 1;
        r = r - 1;
    end
end

% Parameters required for the following traversal
k = n*n;
k_mod2 = mod(k,2);

% Traverse the lower right half of the input matrix
for i = n:-1:2
    r = i;
    for j = n:-1:i
        % Ensure that the direction of traversal is reversal after each
        % diagonal
        if mod(i,2) == k_mod2
            out(k) = x(r,j);
        else
           out(k) = x(j,r);
        end
        % Increment the row index and decrement the column index
        k = k - 1;
        r = r + 1;
    end
end