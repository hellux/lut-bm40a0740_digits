addpath('src/lib');

W = 30;
data = read_digits('training_data');

data_scaled = cell(10, 1);
for i = 0:9
    for j = 1:1
        data_raster{i+1}{j} = preprocess(data{i+1}{j}, W);
    end
end

for i = 0:9
    for j = 1:1
        figure;
        subplot(2, 1, 1);
        plot(data{i+1}{j}(:, 1), data{i+1}{j}(:, 2));
        subplot(2, 1, 2);
        imshow(data_raster{i+1}{j});
        axis([0 W 0 W]);
    end
end

pause;
