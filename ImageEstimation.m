close all

player1 = imread('Player_1.png');
player2 = imread('Player_2.png');
row = 272;
col = 136;
dim = 3;

player1_YCBCR = rgb2ycbcr(player1);
player2_YCBCR = rgb2ycbcr(player2);

player1_Y = player1_YCBCR(:,:,1);
player2_Y = player2_YCBCR(:,:,1);
player1_CB = player1_YCBCR(:,:,2);
player2_CB = player2_YCBCR(:,:,2);
player1_CR = player1_YCBCR(:,:,3);
player2_CR = player2_YCBCR(:,:,3);


diff_img = zeros(size(player1_Y));

for i=1:row
    for j=1:col
        diff_img(i,j) = abs(player1_YCBCR(i,j,1) - player2_YCBCR(i,j,1));
    end
end

figure();
subplot(1,3,1);
imshow(player1_Y);
subplot(1,3,2);
imshow(player2_Y);
subplot(1,3,3);
imshow(diff_img);

%%Calculter the SNR

sum = 0;
sqr_diffimg = 0;
for i=1:row
    for j=1:col
        sum = sum + double(player2_Y(i,j))^2;
        sqr_diffimg  = sqr_diffimg + double(diff_img(i,j))^2;
    end
end

temp = double(sum/sqr_diffimg);
SNR=10*log10(temp);

%%Motion Estimation

Est_img = MotionEstimation(player1_Y, player2_Y);
Est_img(1:row,1:9) = double(player1_Y(1:row,1:9)); %%left column
Est_img(1:row, col-9:col) = double(player1_Y(1:row, col-9:col));  %%right column
Est_img(1:9,1:col) = double(player1_Y(1:9, 1:col));  %%top row
Est_img(row-9:row,1:col) = double(player1_Y(row-9:row, 1:col)); %%bottom row

sum = 0;    %%Estimate SNR
sqr_diffimg = 0;
for i=1:row
    for j=1:col
        sum = sum + double(player2_Y(i,j))^2;
        sqr_diffimg  = sqr_diffimg + double(player2_Y(i,j) - Est_img(i,j))^2;
    end
end
temp = double(sum/sqr_diffimg);
new_SNR=10*log10(temp);

Est_img = uint8(Est_img);
new_estimg = zeros(size(player1));
new_estimg(:,:,1) = Est_img;
new_estimg(:,:,2) = player1_CB;
new_estimg(:,:,3) = player1_CR;

figure();
subplot(1,3,1);
imshow(player1_Y);
title('player 1')
subplot(1,3,2);
imshow(Est_img);
title('Estimated Image Y');
subplot(1,3,3);
imshow(player2_Y);
title('player 2')

Est_imgRGB = YCBCRtoRGB(new_estimg);
figure();
subplot(1,3,1);
imshow(player1);
title('player 1')
subplot(1,3,2);
imshow(Est_imgRGB);
title('Estimated Image');
subplot(1,3,3);
imshow(player2);
title('player 2')
