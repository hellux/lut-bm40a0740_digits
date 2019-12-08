function [dilated, raster, scaled] = preprocess(d)
    W = 20;
    f_merge = @(a, b) max(a, b);

    scaled = rescale(d, W-2);
    raster = rasterize_wu(scaled, W-2, f_merge);
    dilated = dilate(raster);
end
