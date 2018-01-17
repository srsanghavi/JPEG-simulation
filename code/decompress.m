yName='y.txt';
cbName='cb.txt';
crName='cr.txt';


straighty=unrle(yName);
y_dct_quant=0;
i=1;
j=i;
k=1;
while (i<width)
   while (j<height)
       block=zigzag_1(straighty(k,:));
       y_dct_quant(i:i+7,j:j+7)=block;     
       j=j+8;
       k=k+1;
   end
   j=1;
   i=i+8;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%get Cb%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
straightcb=unrle(cbName);
Cb_down_dct_quant=0;
i=1;
j=i;
k=1;
while (i<=width/2)
   while (j<=height/2)
       block=zigzag_1(straightcb(k,:));
       Cb_down_dct_quant(i:i+7,j:j+7)=block;     
      j=j+8;
       k=k+1;
   end
   j=1;
   i=i+8;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%get Cr%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
straightcr=unrle(crName);
Cr_down_dct_quant=0;
i=1;
j=i;
k=1;
while (i<=width/2)
   while (j<=height/2)
       block=zigzag_1(straightcr(k,:));
       Cr_down_dct_quant(i:i+7,j:j+7)=block;     
       j=j+8;
       k=k+1;
   end
   j=1;
   i=i+8;
end


 %%%%%%%%%%%%%%%%%%%%%%%% DECOMPRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % De-quantization
    de_quant_y = @(block_struct) block_struct.data .* Q_y;
    de_quant_c = @(block_struct) block_struct.data .* Q_c;
    y_dct = blockproc(y_dct_quant, [8 8], de_quant_y);
    Cb_down_dct = blockproc(Cb_down_dct_quant, [8 8], de_quant_c);
    Cr_down_dct = blockproc(Cr_down_dct_quant, [8 8], de_quant_c);

    % Block wise (8x8) iDCT of chrominance and luminance
    idct = @(block_struct) idct2(block_struct.data);
    y_idct = blockproc(y_dct, [8 8], idct);
    Cb_down_idct = blockproc(Cb_down_dct, [8 8], idct);
    Cr_down_idct = blockproc(Cr_down_dct, [8 8], idct);

    % Upsampling Chrominance using bilinear transform
    Cb_up = imresize(Cb_down_idct, 2, 'bilinear');
    Cr_up = imresize(Cr_down_idct, 2, 'bilinear');
    
    %Reconstructing the chrominance and luminance of the same size
    y_reconstruct = y_idct(1:width, 1:height);
    Cb_up_reconstruct = Cb_up(1:width, 1:height);
    Cr_up_reconstruct = Cr_up(1:width, 1:height);
    
    % Reconstruct image similar to original ycc image
    ycc_reconstruct = zeros([width,height,3]);
    ycc_reconstruct(:,:,1) = y_reconstruct;
    ycc_reconstruct(:,:,2) = Cb_up_reconstruct;
    ycc_reconstruct(:,:,3) = Cr_up_reconstruct;
    ycc_reconstruct = uint8(ycc_reconstruct);

    % Reconstruct image similar to original RGB image
    RGB_reconstruct = uint8(ycbcr2rgb(ycc_reconstruct));

    imshow(RGB_reconstruct);
