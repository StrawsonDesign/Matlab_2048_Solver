function [best_score,best_dir] = recursive_test(old, order)

    best_score=uint64(0);
    best_dir = 0;
    new = 0;
    moves = [0 0 0 0];
    m=0;
    
    
    %% if order is 1, we have reached the last step
    if (order==1)
        [new, best_score, best_dir] = test_all_moves(old);
        return;
    end
    
    %% otherwise go another level deeper
    % for each direction
    for d=1:4
        score_d=uint64(0);
        
        %try a direction
        [new_d, points_d, moves(d)] = slide(old, d, 2);
        % get openings, the number of possible outcomes of random tile
        if(moves(d)~=0)
            [j,k,openings]=size(new_d);

            for o=1:openings
                % if that direction actually moved something, go a level deeper
                [score_o,dir_i] = recursive_test(new_d(:,:,o), order-1);
                score_d=score_d+score_o;
            end
            score_d=(score_d/openings);
        end
        score_d=score_d+points_d;
        if(score_d>best_score)
           best_dir=d;
           best_score=score_d;
        end
    end
    
    %% if no points were found, check if any moves were made at all
    if(best_dir==0)
        [m,best_dir] = max(moves);
        if m==0
            best_dir=0;  %no moves were made, set dir to 0 indicating stuck
        end
    end
    
   
   

end