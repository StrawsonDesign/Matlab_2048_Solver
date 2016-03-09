%% old is matrix to be permutated
%% dir is direction, 1-4 up down left right
%% pos is the position to put the new number in
%% if fill=1, a random block will be placed
%% if fill==0 nothing will be inserted
%% if fill==2, all possible outcomes will be returned
%% otherwise all possible outcomes are returned in 3d array

function [new, points, moves] = slide(old, dir, fill)

% shift amounts in x and y
new = old;
points=0;
comb=0;
moves=0;

[n,m] = size(old); 

switch dir
%% up
case 1 
for i = 1:n
    % check for pairs
    for j = 1:n-1
        % if non-zero entry, look for a match
        if(new(j,i)>0)
            for k=j+1:n
                if((new(k,i)~=new(k,i))&&(new(k,i)~=0))
                    break
                elseif(new(k,i)==new(j,i))
                    new(j,i)=new(j,i)*2;
                    new(k,i)=0;
                    points = points+new(j,i);
                    comb = comb+1;
                    j=k;
                    break;
                end  
            end
        end
    end
    % shuffle everything over
    for j = 1:n-1
         % if there is a zero, look left to fill it in
         if(new(j,i)==0)
             for k=j+1:n
                if(new(k,i)>0)
                    new(j,i)=new(k,i);
                    new(k,i)=0;
                    moves=moves+1;
                    break;
                end  
            end
         end
    end
end   
    
    
    
    
    
%% down
case 2 
for i = 1:n
    % check for pairs
    for j = -(-n:-2)
        % if non-zero entry, look for a match
        if(new(j,i)>0)
            for k=-(-(j-1):-1)
                if((new(k,i)~=new(j,i))&&(new(k,i)~=0))
                    break
                elseif(new(k,i)==new(j,i))
                    new(j,i)=new(j,i)*2;
                    new(k,i)=0;
                    points = points+new(j,i);
                    comb = comb+1;
                    j=k;
                    break;
                end  
            end
        end
    end
    % shuffle everything over
    for j = -(-n:-1)
         % if there is a zero, look left to fill it in
         if(new(j,i)==0)
             for k=-(-(j-1):-1)
                if(new(k,i)>0)
                    new(j,i)=new(k,i);
                    new(k,i)=0;
                    moves=moves+1;
                    break;
                end  
            end
         end
    end
end 



    
%% left
case 3 
for i = 1:n
    % check for pairs
    for j = 1:n-1
        % if non-zero entry, look for a match
        if(new(i,j)>0)
            for k=j+1:n
                if((new(i,k)~=new(i,j))&&(new(i,k)~=0))
                    break
                elseif(new(i,k)==new(i,j))
                    new(i,j)=new(i,j)*2;
                    new(i,k)=0;
                    points = points+new(i,j);
                    comb = comb+1;
                    j=k;
                    break;
                end  
            end
        end
    end
    % shuffle everything over
    for j = 1:n-1
         % if there is a zero, look left to fill it in
         if(new(i,j)==0)
             for k=j+1:n
                if(new(i,k)>0)
                    new(i,j)=new(i,k);
                    new(i,k)=0;
                    moves=moves+1;
                    break;
                end  
            end
         end
    end
end




    
%% right
case 4
for i = 1:n
    % check for pairs
    for j = -[-n:-2]
        % if non-zero entry, look for a match
        if(new(i,j)>0)
            for k=-(-(j-1):-1)
                if((new(i,k)~=new(i,j))&&(new(i,k)~=0))
                    break
                elseif(new(i,k)==new(i,j))
                    new(i,j)=new(i,j)*2;
                    new(i,k)=0;
                    points = points+new(i,j);
                    comb = comb+1;
                    j=k;
                    break;
                end  
            end
        end
    end
    % shuffle everything over
    for j = -(-n:-1)
         % if there is a zero, look left to fill it in
         if(new(i,j)==0)
             for k=-(-(j-1):-1)
                if(new(i,k)>0)
                    new(i,j)=new(i,k);
                    new(i,k)=0;
                    moves=moves+1;
                    break;
                end  
            end
         end
    end
end 

    
points=uint64(points);
    
    
    
    %% otherwise
otherwise
%     disp('invalid direction dir')
    return
end

switch fill
    case 0 % do nothing
        return

%% if fill==1, do a random position
    case 1
    [new, added] = insert_new(new, 0);
    moves=moves+added;
    
%% else return all possible outcomes  
    case 2
    % count openings
    openings=count_openings(new);
    if(openings==0)
       new_all=zeros(n,n,openings);
       new_all(:,:,1)=new;
    else
        new_all=zeros(n,n,openings);

        for i=1:openings
            [new_i, added] = insert_new(new, i);
            new_all(:,:,i)=new_i;
        end
        moves=moves+1;
        new=new_all;
    end
end

points = uint64(points);

% end function
end