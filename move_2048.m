function [updated_board , valid_move, score] = move_2048 (direction, board, score)

valid_move = true;
updated_board = board;
isCombined = false(4,4);

switch direction

case 'w'    % assume w represents up

    for i = 2 : 4 
        for j = 1 : 4
            for k = i - 1 : -1 : 1
                if board(k,j) == 0
                    board(k,j) =  board(k+1,j);
                    board(k+1,j) = 0 ;
                end
                if board(k,j) == board(k+1,j) && ~isCombined(k,j) && ~isCombined(k+1,j) && board(k,j)~=0
                    board(k,j) =  board(k,j) * 2;
                    score = score + board(k,j);
                    board(k+1,j) = 0 ;
                    isCombined(k,j) = true;         
                end
            end
        end
    end


case 's'    % assume s represents down

    for i = 3 : -1 : 1 
        for j = 1 : 4
            for k = i + 1 : 4
                if board(k,j) == 0
                    board(k,j) =  board(k-1,j);
                    board(k-1,j) = 0 ;
                end
                if board(k,j) == board(k-1,j) && ~isCombined(k,j) && ~isCombined(k-1,j) && board(k,j)~=0
                    board(k,j) =  board(k,j) * 2;
                    score = score + board(k,j);
                    board(k-1,j) = 0 ; 
                    isCombined(k,j) = true;         
                end
            end
        end
    end

case 'd' % assume d represents right

    for i = 1 : 4
        for j = 3 : -1 : 1 
            for k = j + 1 : 4
                if board(i,k) == 0
                    board(i,k) =  board(i,k-1);
                    board(i,k-1) = 0 ;
                end
                if board(i,k) == board(i,k-1) && ~isCombined(i,k) && ~isCombined(i,k-1) && board(i,k)~=0
                    board(i,k) =  board(i,k) * 2;
                    score = score + board(i,k);
                    board(i,k-1) = 0 ; 
                    isCombined(i,k) = true;         
                end
            end
        end
    end

case 'a'    % assume a represents left

    for i = 1 : 4 
        for j = 2 : 4
            for k = j - 1 : -1 : 1
                if board(i,k) == 0
                    board(i,k) =  board(i,k+1);
                    board(i,k+1) = 0 ;
                end
                if board(i,k) == board(i,k+1) && ~isCombined(i,k) && ~isCombined(i,k+1) && board(i,k)~=0
                    board(i,k) =  board(i,k) * 2;
                    score = score + board(i,k);
                    board(i,k+1) = 0 ; 
                    isCombined(i,k) = true;         
                end
            end
        end
    end

otherwise
    valid_move = false;
    disp('It is not a valid key');
end

% if nothing has changed after the move, it should be also regarded as invalid move
if updated_board == board;
    valid_move = false;
else
    updated_board = board;
end

