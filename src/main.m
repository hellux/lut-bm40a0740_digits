clc;
clearvars;
close all;

addpath('src/data');
addpath('src/preprocess');
addpath('src/training');

W = 18;
d = read_digits('training_data');

d_scaled = cell(1, 10);
d_raster = cell(1, 10);
d_thick = cell(1, 10);
for i = 0:9
    for j = 1:100
        d_scaled{i+1}{j} = rescale(d{i+1}{j}, W);
        f_merge = @(a, b) max(a, b);
        d_raster{i+1}{j} = rasterize_wu(d_scaled{i+1}{j}, W, f_merge);
        d_thick{i+1}{j} = thicken(d_raster{i+1}{j});
    end
end

for i = 0:0
    for j = 1:1
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

[a, b] = size(d_thick{1}{1});
data = zeros(W ^ 2, 1000);
class = zeros(1, 1000);
for j = 1:100
    for i = 0:9
        class((j - 1) * 10 + i + 1) = i + 1;
        for k1 = 1:a
            for k2 = 1:b
                data((k1 - 1) * b + k2, (j - 1) * 10 + i + 1) = d_thick{i + 1}{j}(k1, k2);
            end
        end
    end
end

traindata = data(:, 1:500);
trainclass = class(1:500);
testdata = data(:, 501:1000);
testclass = class(501:1000);

[a, b, c, d] = mlp(traindata, trainclass, testdata, 1000, 10);
err = sum(a ~= testclass)
1 - err / length(testclass)
