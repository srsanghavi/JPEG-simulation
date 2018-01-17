% function (vector) straight = zigzag ((matrix) block)
% The function zigzag takes a matrix (8x8) as an input argument and traverses
% in zigzag fashion on the matrix, converting this matrix into a vector of
% dimension 1x64 as needed in JPEG compression.

function straight = zigzag(block)    
    straight = zeros(1,64);
    straight(1) = block(1,1);            
    straight_index = 2;
    x_index = 1;
    y_index = 2;
    flag = 1;
    while straight_index < 65
        % Cross Traverse down
        if flag == 1
            straight(straight_index) = block(x_index,y_index);                    
            x_index = x_index + 1;
            y_index = y_index - 1;
        % Cross Traverse up
        elseif flag == 2
            straight(straight_index) = block(x_index,y_index);
            x_index = x_index - 1;
            y_index = y_index + 1;
        end
        straight_index = straight_index + 1;
        % Boundary conditions for zig-zag encoding on 8x8 block
        % Current position is in the bottom right corner of cube
        if(x_index > 8 && y_index < 1)
            x_index = 8;
            y_index = 2;
            flag = 2;        
        % Current position is in the bottom of cube
        elseif(y_index < 1)
            y_index = y_index + 1;
            flag = 2;        
        % Current position is in the left side of cube
        elseif(x_index < 1)
            x_index = x_index + 1;
            flag = 1;        
        % Current position is in the top of cube            
        elseif(y_index > 8)
            y_index = y_index - 1;
            x_index = x_index + 2;
            flag = 1;       
        % Current position is in the right side of cube            
        elseif(x_index > 8)
            x_index = x_index - 1;
            y_index = y_index + 2;
            flag = 2;       
        end
    end    
end