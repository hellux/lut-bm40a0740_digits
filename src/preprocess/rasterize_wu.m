% rasterize line segments of curve using Wu's algorithm
function img = rasterize_wu(curve, W, f_merge)
    img = zeros(W, W);
    for i = 1:(length(curve)-1)
        pixels = draw_line_wu(curve(i,   1), curve(i,   2), ...
                              curve(i+1, 1), curve(i+1, 2));
        for j = 1:size(pixels, 1)
            pixel = pixels(j, :);
            x = pixel(1)+1; y = W-pixel(2);
            prev = img(y, x);
            new = pixel(3);
            img(y, x) = f_merge(prev, new);
        end
    end
end

function y = fpart(x)
    y = x - floor(x);
end

function y = rfpart(x)
    y = 1 - fpart(x);
end

function pixels = draw_line_wu(x0, y0, x1, y1)
    pixels = zeros(0, 3);
    steep = abs(y1-y0) > abs(x1-x0);
    
    if steep % swap x and y
        [x0, y0] = deal(y0, x0);
        [x1, y1] = deal(y1, x1);
    end
    
    if x0 > x1 % swap endpoints
        [x0, x1] = deal(x1, x0);
        [y0, y1] = deal(y1, y0);
    end
    
    dx = x1-x0; dy = y1-y0;
    if dx == 0
        gradient = 1;
    else
        gradient = dy/dx;
    end
    
    xend = round(x0);
    yend = y0 + gradient*(xend-x0);
    xgap = rfpart(x0+0.5);
    xpxl1 = xend;
    ypxl1 = floor(yend);
    if steep
        pixels(end+1, :) = [ypxl1 xpxl1 (rfpart(yend)*xgap)];
        pixels(end+1, :) = [(ypxl1+1) xpxl1 (fpart(yend)*xgap)];
    else
        pixels(end+1, :) = [xpxl1 ypxl1 rfpart(yend)*xgap];
        pixels(end+1, :) = [xpxl1 (ypxl1+1) (fpart(yend)*xgap)];
    end
    intery = yend + gradient;
    
    xend = round(x1);
    yend = y1 + gradient*(xend-x1);
    xgap = fpart(x1+0.5);
    xpxl2 = xend;
    ypxl2 = floor(yend);
    if steep
        pixels(end+1, :) = [ypxl2     xpxl2 (rfpart(yend)*xgap)];
        pixels(end+1, :) = [(ypxl2+1) xpxl2 (fpart(yend)*xgap)];
    else
        pixels(end+1, :) = [xpxl2 ypxl2     (rfpart(yend)*xgap)];
        pixels(end+1, :) = [xpxl2 (ypxl2+1) (fpart(yend)*xgap)];
    end
    
    for x = (xpxl1+1):(xpxl2-1)
        if steep
            pixels(end+1, :) = [floor(intery)     x rfpart(intery)];
            pixels(end+1, :) = [(floor(intery)+1) x fpart(intery)];
        else
            pixels(end+1, :) = [x floor(intery) rfpart(intery)];
            pixels(end+1, :) = [x (floor(intery)+1) fpart(intery)];
        end
        intery = intery + gradient;
    end
end
