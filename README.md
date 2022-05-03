# Motion-Estimation
Motion estimation of two given image.

This miniproject implement motion estimation between two different images. (Player1 and Player2)

Algorithm:
1. Find each 8*8 nonoverlapping blocks in player2 and its corresponding 8*8 block in player1
2. Find the 8-neighborhood 8*8 block in player1
3. Find the one that has the lowest block error comparing to the 8*8 block for plater2 in step one 
4. Replace the 8*8 block in player1 that has the lowest block error.
5. Repeat the steps through the whole image




