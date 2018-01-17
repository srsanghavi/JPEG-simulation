close all;
%Read Image
RGB = readImage('iR.bin','iG.bin','iB.bin');
imshow(RGB);
% Convert to YCbCr
ycc = rgb2ycbcr(RGB);
% Downsampling using bilinear transformation
y = ycc(:,:,1);
Cb = ycc(:,:,2);
Cr = ycc(:,:,3);
Cb_down = imresize(Cb, 0.5, 'bilinear');
Cr_down = imresize(Cr, 0.5, 'bilinear');

% Convert the luminance height and width to multiple of 8
if rem(size(y,1),8) ~= 0
    y = [y; zeros(8-rem(size(y,1),8), size(y,2))];    
end
if rem(size(y,2),8) ~= 0
    y = [y zeros(size(y,1), 8-rem(size(y,2),8))];    
end

% Convert the chrominance height and width to multiple of 8
if rem(size(Cb_down,1),8) ~= 0
    Cb_down = [Cb_down; zeros(8-rem(size(Cb_down,1),8), size(Cb_down,2))];
    Cr_down = [Cr_down; zeros(8-rem(size(Cr_down,1),8), size(Cr_down,2))];
end
if rem(size(Cb_down,2),8) ~= 0
    Cb_down = [Cb_down zeros(size(Cb_down,1), 8-rem(size(Cb_down,2),8))]; 
    Cr_down = [Cr_down zeros(size(Cr_down,1), 8-rem(size(Cr_down,2),8))]; 
end

%%%%%%%%%%%%%%%%%%%%%%%% COMPRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Block wise (8x8) DCT of chrominance and luminance 
dct = @(block_struct) dct2(block_struct.data);
y_dct = blockproc(y, [8 8], dct);
Cb_down_dct = blockproc(Cb_down, [8 8], dct);
Cr_down_dct = blockproc(Cr_down, [8 8], dct);

% Quantization of chrominance and luminance
quant_y = @(block_struct) round(block_struct.data ./ Q_y);
quant_c = @(block_struct) round(block_struct.data ./ Q_c);
y_dct_quant = blockproc(y_dct, [8 8], quant_y);
Cb_down_dct_quant = blockproc(Cb_down_dct, [8 8], quant_c);
Cr_down_dct_quant = blockproc(Cr_down_dct, [8 8], quant_c);
xyz=1;             
%Zigzag encoding
fh = fopen('y.txt','w');        
for i = 1:8:size(y_dct_quant,1)
    for j = 1:8:size(y_dct_quant,2)    
        block = y_dct_quant(i:i+7, j:j+7);
        straight = zigzag_1(block);                        
        %Apply RLE on the vector
        %int2str(uint8(straight))
        rle(straight,fh);            
        xyz=xyz+1;
    end                
end
fprintf(fh,'%c','.');
fclose(fh);

 %Zigzag encoding for chrominance   
 fcb = fopen('cb.txt','w'); 
 fcr = fopen('cr.txt','w');  
for i = 1:8:size(Cr_down_dct_quant,1)
    for j = 1:8:size(Cr_down_dct_quant,2)    
        %for Cr
        block = Cr_down_dct_quant(i:i+7, j:j+7);
        straight = zigzag_1(block);                        
        %Apply RLE on the vector
        rle(straight,fcr);            
        %for Cb
        block = Cb_down_dct_quant(i:i+7, j:j+7);
        straight = zigzag_1(block);                        
        %Apply RLE on the vector
        rle(straight,fcb);            
    end                
end
fprintf(fcb,'%c','.');
fclose(fcb);
fprintf(fcr,'%c','.');
fclose(fcr);