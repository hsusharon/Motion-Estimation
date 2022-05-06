function RGBimg = YCBCRtoRGB(YCBCRimg)
    RGBimg = zeros(size(YCBCRimg));
    Y = YCBCRimg(:,:,1);
    Cb = YCBCRimg(:,:,2);
    Cr = YCBCRimg(:,:,3);
    col = 136;
    row = 272;
    for i = 1:row
        for j = 1:col
            RGBimg(i,j,1) = (298.082*Y(i,j))/256 + (408.583*Cr(i,j))/256 - 222.921;
            RGBimg(i,j,2) = (298.082*Y(i,j))/256 - (100.291*Cb(i,j))/256 -(208.12*Cr(i,j))/256 + 135.579;
            RGBimg(i,j,3) = (298.082*Y(i,j))/256 + (516.412*Cb(i,j))/256 - 276.836;
        end
    end
    RGBimg = uint8(RGBimg);
end