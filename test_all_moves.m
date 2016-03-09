function [new, best_points, best_dir] = test_all_moves(old)

    best_points=0;
    best_dir = 0;
    new = 0;
    moves = [0 0 0 0];
    m=0;
    
    for i=1:4
        [new_i, points_i, moves_i] = slide(old, i, 0);
        moves(i) = moves_i;
        if(points_i>best_points)
           new=new_i;
           best_dir=i;
           best_points=points_i;
        end
    end
    
    %% if no points were found, check if any moves were made at all
    if(best_dir==0)
        [m,best_dir] = max(moves);
        if m==0
            best_dir=0;
        end
        [new, best_points, moves] = slide(old, best_dir, 0);
    end
    
    %no moves were made, set dir to 0 indicating stuck
   

end