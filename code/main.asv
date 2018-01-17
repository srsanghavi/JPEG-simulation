clear all;
q_factor=5;
height=698;
width=250;

%%%%%%%%%%%%%%%%%%%%%%%%%%% PRE-PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%
if q_factor < 50
    q_scale = floor(5000 / q_factor);
else
    q_scale = 200 - 2 * q_factor;
end
% Initialization of quantization matrices for chrominance and luminance
% Quant luminance
Q_y = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 
    14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; 
    18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; 
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];
% Quant chrominance
Q_c = [ 17 18 24 47 99 99 99 99 ;18 21 26 66 99 99 99 99 ;
    24 26 56 99 99 99 99 99; 47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99; 
    99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99 ] ;

% Scale Quant luminance and chrominance
Q_y = round(Q_y .* (q_scale / 100));
Q_c = round(Q_c .* (q_scale / 100));



compress
figure;
decompress