addpath('src/data');
addpath('src/preprocess');

digits = read_digits('training_data');
digits = split_data(digits, 1, 99, 0);
[digits, class] = flatten(digits);

for i = 1:length(digits)
    d = digits{i};
    W = 28;
    f_merge = @(a, b) max(a, b);

    scaled = rescale(d, W-2);
    raster = rasterize_wu(scaled, W-2, f_merge);
    thick = thicken(raster);

    figure;
    subplot(2, 2, 1); plot(scaled(:, 1), scaled(:, 2));
    axis([0 W 0 W]);
    title(int2str(class(i)), 'fontsize', 20);
    subplot(2, 2, 2); imshow(raster);
    subplot(2, 2, 3); imshow(thick);
end

pause;
