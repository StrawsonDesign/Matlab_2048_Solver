%% fiddling with 2048


clear all
close all
clc
format short

n=4; % square matrix height/width

%% recursive depth
% 3 -> fast
% 4 -> medium
% 5 -> painfully slow
recursive_depth = 5;

%% absolute starting points
start = [ 0 0 0 0;
          0 0 0 0;
          0 0 2 0;
          0 0 0 0];

%% for testing to 8k
start = [ 8         32        16          4;
          0          0        4096        128;
          0          2         0           0;
          0          0         0           2];
      
%% for testing to 16k
start = [ 8         32        16          4;
          0          0        8192        128;
          0          2         0           0;
          0          0         0           2];
      
      
%% best so far!
% start = [ 4          16       128         2;
%          32          64       256         4;
%          1024       4096      512         32;
%           2           8      16384        16];


%% make sure the matrix and score uses ints not floats
new = uint32(start);
score=uint64(0);

for i=1:100000
        
    % lower recursive depth for sparse matrix to save time
    open=count_openings(new);
    depth = recursive_depth;
    if(open>=5)
        depth=depth-1;
    end
    
    % lower recursive depth again if you are not close to a new big number
    % this is done by counting unique values
    uniques = size(unique(new(:)))
    if(uniques(1)<=9)
        depth = depth-1;
    end
   
    % run the test
    [points,dir] = recursive_test(new, depth);
	if dir==0
        disp('game over')
        break
    else
        % real move with random tile inserted
        [new, points, moves] = slide(new, dir, 1); 
        score=score+points;
%         i
%         points
%         dir
        score
        new
    end
end
