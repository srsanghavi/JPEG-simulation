% function output = zigzag (input)
% The function zigzag takes a matrix (8x8) or a vector as an input
% argument.
% Based on the input if performs zigzag encoding or decoding

function output = zigzag_1(input)
    % Init indices
    straight_index = 2;
    x_index = 1;
    y_index = 2;
    flag = 1;
    % Matrix to vector (Encoding)
    if size(input,1) == 8 && size(input,2) == 8
        output = zeros(1,64);
        output(1) = input(1,1);     
        input_flag = 1;
    % Vector to matrix (Decoding)
    elseif size(input,1) == 1 && size(input,2) == 64
        output = zeros(8,8);
        output(1,1) = input(1);
        input_flag = 2;
    end
    while straight_index < 65
        % Check matrix to vector or vice versa
        if input_flag == 1
            output(straight_index) = input(x_index,y_index);
        elseif input_flag == 2
            output(x_index,y_index) = input(straight_index);                    
        end
        % Cross Traverse down
        if flag == 1            
            x_index = x_index + 1;
            y_index = y_index - 1;
        % Cross Traverse up
        elseif flag == 2            
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