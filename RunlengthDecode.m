function R = RunlengthDecode(x)
% This function applies run-length decoding on the value 0

% Input: 'x' is the encoded stream.

% Output: 'R' is the decoded stream.


R = [];
i = 1;
% Sweep on all the characters in the stream
while i <= length(x)
    % If a zero flag is encountered, produce the encoded number of zeroes
    if x(i) == 0
        R = [R zeros(1,x(i+1))];
        i = i + 1;
    else
        % If another character is encountered, store it as is
        R = [R x(i)];
    end
    i = i + 1;
end
end