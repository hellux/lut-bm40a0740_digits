function img_new = thicken(img)
    dilation = [0.5 0.8 0.5;
                0.8 1.0 0.8;
                0.5 0.8 0.5];
    img_new = conv2(img, dilation);
end
