function demonstration

%initial setting
board = initialize_board; %To start a random board
previous_board = board;
score = 0;
previous_score = 0;
goal = 2048; %win conditon
clc;

% To find the highest score record of the game
if exist('record.mat', 'file') == 2
    load ('record.mat');
else
    highest_score = 0;
end

while true
    
    %Display the board and information
    disp(['Score = ' , num2str(score), '   Highest score = ', num2str(highest_score)]);
    fprintf('\n');
    disp(board);
    

    %Check lose condition
    [~, valid_left]  =  move_2048('a',board,score);
    [~, valid_right] =  move_2048('d',board,score);
    [~, valid_up]    =  move_2048('w',board,score);
    [~, valid_down]  =  move_2048('s',board,score);
    
    if ~valid_left && ~valid_right && ~valid_up && ~valid_down
         disp('You Lose')
         key = input('You can press r to reset (or other key to end) ','s');
         if key == 'r'
             board = previous_board;
             score = previous_score;
             clc
             disp(['Score = ' , num2str(score), '   Highest score = ', num2str(highest_score)]);
             fprintf('\n');
             disp(board);
         else
         break
         end
    end
    
    %Check win condition
    if checkwin(goal,board)
        disp('You Win')
        break
    end
    
    %Request user to input a key, 
    %Enter key w,a,s,d
    key = input('Please enter a key to move: (press r to reset) :  ','s');
    clc;
    
    %Update the board
    if key == 'r' %to reset
        board = previous_board;
        score = previous_score;
    else %to move
        [updated_board, valid_move, updated_score] = move_2048(key,board,score);
        %only update information when valid move is made
        if valid_move
            previous_board = board;
            previous_score = score;
            board = updated_board;
            score = updated_score;
            board = generate_block(board);
        end
    end
    
    %Determine the highest score
    if score > highest_score
        highest_score = score;
        save('record.mat' ,'highest_score');
    end   
end




