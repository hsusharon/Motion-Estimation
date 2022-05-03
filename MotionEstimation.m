function [Est_image] = MotionEstimation(player1,player2)
    row = 272;
    col = 136;
    block = 8;
    Est_image = zeros(size(player1));
    target = zeros(block,  block);
    for i=9:block:row-8   %%every 8*8 block
        for j=9:block:col-8
            min = 1000000;
            player2_block = player2(i:i+block-1, j:j+block-1);
            for k = -1:1    %% 8-neighborhood
                for l = -1:1
                    player1_block = player1(i+k*8:i+k*8+8-1, j+l*8:j+l*8+8-1);
                    temp = double(player2_block) - double(player1_block);
                    %temp = double(temp);
                    block_sum = blocksum(temp);
                    if(block_sum < min)
                         min = block_sum;
                         target = player1_block;
                    end
                end
            end
            for k = 1:block
                for l = 1:block
                    Est_image(i+k-1,j+l-1) = target(k,l);
                end
            end
        end
    end
    
end