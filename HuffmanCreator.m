function codes = HuffmanCreator(symsArray, probsArray)
% This function creates the Huffman code for each character and saves
% the encoding table in a text file.

n = length(probsArray); 
% This cell will be used to store the codes for each character
codes = cell(1, n);
% This cell will be used to keep track of the encoded characters
temp = cell(1, n);

for i = 1:n
    temp{i} = i; 
end

% This cell will be used to keep track of the probabilities of each
% character or group of characters
temp2 = [probsArray; 1:n]; 

for i = 1:n-1
    % Order the characters according to their probabilities
    temp2 = (sortrows(temp2.', 1)).'; 
    temp = mixup(temp, temp2(2, :));
    
    % For the character (or group of characters) with the least probability
    % add 0 to its/their code
    for j = 1:length(temp{1})
        codes{temp{1}(j)} = strcat('0', codes{temp{1}(j)}); 
    end
    
    % For the character (or group of characters) with the second least 
    % probability add 1 to its/their code
    for j = 1:length(temp{2})
        codes{temp{2}(j)} = strcat('1', codes{temp{2}(j)}); 
    end
    
    % Save the characters with the least two probabibilities as one element
    temp{1} = [temp{1} temp{2}]; 
    temp2(1, 1) = temp2(1,1) + temp2(1, 2); 
    
    % Replace the second character with 0 and probability of 2 
    % so that it is excluded in the next loop
    temp{2} = 0;
    temp2(1, 2) = 2; 
    
    % Reorder the indices of the characters
    temp2(2, :) = 1:n;     
end

fileID = fopen('HuffmanCodes.txt', 'w');

% Print the encoding table
fprintf(fileID, 'Symbol Code\n');
for i = 1:n
    fprintf(fileID, '%d      %s\n', symsArray(i), codes{i});  
end 
fclose(fileID);
end 