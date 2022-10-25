
Ne=24;
row=4;
col=6;
Ne1=round(Ne/3);
Ne2=Ne1;
Ne3=Ne-Ne1-Ne2;

%----------------------1----------------------
f(1,1:Ne1)=1:Ne1;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Col-1,3)==0
            if mod(Row,2)==0
                f((Row-1)*col+Col+1,:)=f(1,:);
            elseif mod(Row,2)==1
                f((Row-1)*col+Col,:)=f(1,:);
            end
        end
    end
end

%----------------------2----------------------
f(2,1:Ne2)=Ne1+1:Ne1+Ne2;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Col-2,3)==0
            if mod(Row,2)==0
                f((Row-1)*col+Col+1,:)=f(2,:);
            elseif mod(Row,2)==1
                f((Row-1)*col+Col,:)=f(2,:);
            end
        end
    end
end

%----------------------3----------------------
f(3,1:Ne3)=Ne1+Ne2+1:Ne;
for Row=1:row
    for Col=1:col
        if Col<=col&&mod(Col-3,3)==0
            if mod(Row,2)==0
                f((Row-1)*col+Col+1,:)=f(3,:);
            elseif mod(Row,2)==1
                f((Row-1)*col+Col,:)=f(3,:);
            end
        end
    end
end