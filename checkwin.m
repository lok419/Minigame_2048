function isWin = checkwin(goal,board)

isWin = false;
for i= 1 : 4
    for j= 1 : 4
        if board(i,j) >= goal
            isWin = true; 
        end
    end
end