% apply all preprocessing steps to a digit
function d_new = preprocess(d, W)
    d_new = normalize(d, W);
    d_new = rasterize_wu(d_new, W, @(a, b) min(1, a+b));
end

% scale and center digit to WxW square
function d_new = normalize(d, W)
    n = length(d);
    dmin = min(d); dmax = max(d);
    w = dmax(1)-dmin(1); h = dmax(2)-dmin(2);
    scale = 0.8*W/max(w, h);
    x_start = (W-w*scale)/2;
    y_start = (W-h*scale)/2;

    d_new = zeros(n, 2);
    for k = 1:n
        d_new(k, 1) = x_start + (d(k, 1)-dmin(1))*scale;
        d_new(k, 2) = y_start + (d(k, 2)-dmin(2))*scale;
    end
end

% rasterize line segments of curve using Wu's algorithm
function img = rasterize_wu(curve, W, f_merge)
    img = zeros(W, W);
    for i = 1:(length(curve)-1)
        pixels = draw_line_wu(curve(i,   1), curve(i,   2),
                              curve(i+1, 1), curve(i+1, 2));
        for i = 1:size(pixels, 1)
            pixel = pixels(i, :);
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
        [x0 y0] = deal(y0, x0);
        [x1 y1] = deal(y1, x1);
    end

    if x0 > x1 % swap endpoints
        [x0 x1] = deal(x1, x0);
        [y0 y1] = deal(y1, y0);
    end

    dx = x1-x0; dy = y1-y0;
    if dx == 0
        gradient = 1
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
