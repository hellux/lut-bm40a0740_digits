function [thick, raster, scaled] = preprocess(d)
    W = 18;
    f_merge = @(a, b) max(a, b);

    scaled = rescale(d, W-2);
    raster = rasterize_wu(scaled, W-2, f_merge);
    thick = thicken(raster);
end
