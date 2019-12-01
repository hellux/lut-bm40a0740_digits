% scale and center digit to WxW square
function d_new = rescale(d, W)
    n = length(d);
    dmin = min(d); dmax = max(d);
    w = dmax(1)-dmin(1); h = dmax(2)-dmin(2);
    scale = 0.8*W/max(w, h);
    x_start = (W-w*scale)/2 - dmin(1)*scale;
    y_start = (W-h*scale)/2 - dmin(2)*scale;
    
    d_new = zeros(n, 2);
    for k = 1:n
        d_new(k, 1) = x_start + d(k, 1)*scale;
        d_new(k, 2) = y_start + d(k, 2)*scale;
    end
end
