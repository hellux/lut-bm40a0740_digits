function dilated = dilate(img)
    dilation = [0.5 0.8 0.5;
                0.8 1.0 0.8;
                0.5 0.8 0.5];
    dilated = conv2(img, dilation);
end
