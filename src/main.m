addpath('src/lib');
addpath('src/preprocess');

W = 30;
data = read_digits('training_data');

data_scaled = cell(10, 1);
for i = 0:9
    for j = 1:1
        data_scaled{i+1}{j} = rescale(data{i+1}{j}, W);
        f_merge = @(a, b) min(1, a+b);
        data_raster{i+1}{j} = rasterize_wu(data_scaled{i+1}{j}, W, f_merge);
    end
end

for i = 0:9
    for j = 1:1
        figure;
        subplot(2, 1, 1);
        plot(data_scaled{i+1}{j}(:, 1), data_scaled{i+1}{j}(:, 2));
        subplot(2, 1, 2);
        imshow(data_raster{i+1}{j});
        axis([0 W 0 W]);
    end
end

pause;
