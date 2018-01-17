function []=writeImage(imMat)
    fred=fopen('iR.bin','w');
    fgreen=fopen('iG.bin','w');
    fblue=fopen('iB.bin','w');
    iR=imMat(:,:,1);
    iG=imMat(:,:,2);
    iB=imMat(:,:,3);
    fwrite(fred,iR);
    fwrite(fgreen,iG);
    fwrite(fblue,iB);
    fclose(fred);
    fclose(fgreen);
    fclose(fblue);
end