% Function for doing RLE.
% Input: Vector 
% Output: Char1 freq1 char2 freq2 ...,
% Sample 
% Input: [1 1 1 0 0 1 0 1]
% Output: 1 3 0 2 1 1 0 1 1 1 , (in a file named data.txt)

function [] = rle(straight,fh)
    % count the frequency of each character
    i=1;  
    while(i <= size(straight,2))                
        curr = straight(i);
        fprintf(fh,'%s ',int2str(curr));        
        j=i+1;
        while(j <= size(straight,2))        
            if curr == straight(j)
                j = j + 1;
            else
                count = j - i;            
                i = j;                
                break;
            end            
        end 
        if j>size(straight,2)
            count = j-i;
            i = j;
        end
        fprintf(fh,'%s ', int2str(count));
    end
    fprintf(fh,'%c',',');
end
