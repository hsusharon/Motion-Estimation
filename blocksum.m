function sum = blocksum(block)
    size = 8;
    sum = 0;
    for i=1:size
        for j=1:size
            sum = sum + abs(block(i,j));
        end
    end
end