function [i]=readImage(iR,iG,iB)
    fred=fopen(iR);
    fgreen=fopen(iG);
    fblue=fopen(iB);
    iR1=fread(fred,[250 698]);
    iG1=fread(fgreen,[250 698]);
    iB1=fread(fblue,[250 698]);
    i(:,:,1)=iR1;
    i(:,:,2)=iG1;
    i(:,:,3)=iB1;
    i=uint8(i);
end