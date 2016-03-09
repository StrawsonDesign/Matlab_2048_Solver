function open = count_openings(a)

open=0;
[n,m] = size(a);


for i = 1:n
    for j = 1:n
        if(a(i,j)==0)
            open=open+1;
        end
    end
end


end