function R = RunlengthEncode(x)
% This function applies run-length encoding on the value 0

% Input: 'x' is the stream to be encoded.

% Output: 'R' is the encoded stream.


R = [];
i = 1;
% Sweep on all the characters in the stream
while i <= length(x)
    count = 1;
    % If a zero is encountered, count the number of zeroes
    if x(i) == 0
        while i ~= length(x) && x(i+1) == 0
            count = count + 1;
            i = i + 1;
        end
        % Store the number of zeroes along with the 0 flag
        R = [R 0 count];
    else
        %If a zero is not encountered, store the character as is
        R = [R x(i)];
    end
    i = i + 1;
end
end