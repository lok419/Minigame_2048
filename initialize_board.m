function board = initialize_board

board = zeros(4,4); % create a 4x4 board full of 0s

% the sum of zeros(4,4), which is obviously 0 initially
sumOfBoardInRow = (sum(board ~= 0));

% to ensure that there are no more than 2 spaces that are occupied
if(sum(sumOfBoardInRow)) < 2 
    % to get a random point in the board
    %point = [(randi(4,1,2));(randi(4,1,2))]; 
    point = randi(4,2,2);
    
    % if the 2 points are the same, then randomize again
    if( (point(1,1)==point(2,1)) && (point(1,2)==point(2,2)) ) 
        %point = [(randi(4,1,2));(randi(4,1,2))];
        point = randi(4,2,2);
    end
    
    % get a random number of either 2 or 4
    randomNumber = 2.*randi(2,2,1); 
    
    % assign the empty third column with the values of randomNumber, becomes 2 x 3 dimension
    point(:,3) = randomNumber; 
    
    % assign the randomNumber to a randomized grid space
    board(point(1,1),point(1,2)) = point(1,3); 
    
    % assign the randomNumber to the second randomized grid space
    board(point(2,1),point(2,2)) = point(2,3); 
end