function [new, added] = insert_rand(old, pos)

%% insert random number
% count open slots
openings=0;
new=old;
[n,m] = size(old);
added=0;



for i = 1:n
    for j = 1:n
        if(new(i,j)==0)
            openings=openings+1;
        end
    end
end
if(openings==0)
    added=0;
    return
end

%% if pos==0, do a normal random 
if pos=0
    pos=randi(openings);
    for i = 1:n
        for j = 1:n
            if(new(i,j)~=0)
                pos=pos+1;
            elseif (((i-1)*4)+j)==pos

                %% add a random 4 or 2
                r = randi(8);
                if r==8
                   new(i,j)=4;
                else
                   new(i,j)=2;
                end

                added=1;
                return
            end
        end
    end

else
    new=zeros(n,n,openings);
    



end