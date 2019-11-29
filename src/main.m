addpath('src/lib');

W = 30;
data = read_digits('training_data');

data_scaled = cell(10, 1);
for i = 0:9
    for j = 1:10
        d = data{i+1}{j};
        data_scaled{i+1}{j} = preprocess(d, W);
    end
end

plot_digit = @(dig) {figure; plot(dig(:, 1), dig(:, 2)); };
axis([0 W 0 W], 'square');
for i = [0]
    for j = 1:10
        plot_digit(data_scaled{i+1}{j});
    end
end

pause;
