addpath('src/lib');
addpath('src/preprocess');

W = 30;
d = read_digits('training_data');

d_scaled = cell(1, 10);
d_raster = cell(1, 10);
d_thick = cell(1, 10);
for i = 1:1
    for j = 1:10
        d_scaled{i+1}{j} = rescale(d{i+1}{j}, W);
        f_merge = @(a, b) max(a, b);
        d_raster{i+1}{j} = rasterize_wu(d_scaled{i+1}{j}, W, f_merge);
        d_thick{i+1}{j} = thicken(d_raster{i+1}{j});
    end
end

for i = 1:1
    for j = 1:10
        figure;
        subplot(2, 2, 1);
        plot(d_scaled{i+1}{j}(:, 1), d_scaled{i+1}{j}(:, 2));
        axis([0 W 0 W]);
        subplot(2, 2, 2);
        imshow(d_raster{i+1}{j});
        subplot(2, 2, 3);
        imshow(d_thick{i+1}{j});
    end
end

pause;
