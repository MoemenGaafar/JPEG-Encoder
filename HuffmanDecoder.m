function decoded = HuffmanDecoder(characters, codes, inputEncoded)
% This function decodes the characters in the input text using the input 
%code and returns the decoded text.

decoded = [];
currentCode = [];

for i = inputEncoded
   currentCode = [currentCode i];
   for j = 1:length(codes)
       if isequal(currentCode, codes{j}) 
           decoded = [decoded characters(j)];
           currentCode = [];
           break;
       end
   end
end

end