function isLose = checklose(board)

isLose = true;
for i= 1 : 4           
    for j= 2 : 4
        if board(i,j) == board(i,j-1) || board(i,j) == 0 || board(i,j-1) == 0
            isLose = false;
        end
    end
end

for j= 1 : 4
    for i= 2 : 4
        if board(i,j) == board(i-1,j)
            isLose = false;
        end
    end
end
