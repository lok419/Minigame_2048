function updated_board = generate_block(board)

empty_block = [];

% to select all the empty blocks
for i = 1 : 4
    for j = 1 : 4
        if board(i,j) == 0
            empty_block = [empty_block;i,j];
        end
    end
end

%choose one block randomly
r = randi([1,size(empty_block,1)]);

%choose 2 or 4 randomly (chance ratio 9:1)
num = randi([1,10]);

if num == 10
    board( empty_block(r,1) , empty_block(r,2) ) = 4;
else
    board( empty_block(r,1) , empty_block(r,2) ) = 2;
end

updated_board = board;



