function straight=unrle(filename)
    f=fopen(filename,'r');
    row=0;
    while(1)
        x=fscanf(f,'%d');
        if length(x)>=1
            values=0;
            freq=0;
    %         freq=none;
            row=row+1;
            temp=x;
            i=1;
            j=1;
            k=1;
            while (i<=length(x))
                if(mod(i,2) == 1)
                    values(j)= x(i);
                    j=j+1;
                else
                    freq(k)=x(i);
                    k=k+1;
                end
                i=i+1;
            end
            i=1;
            j=1;
            while(i <= length(freq))
                straight(row,j:j+freq(i)-1)=values(i);
                j=j+freq(i);
                i=i+1;
            end
        else
            x=fscanf(f,'%c',1);
            if x==','
    %         	continue;
            elseif x=='.'
                break;
            end
        end
    end
    fclose(f);
end