addpath('src/data');
addpath('src/preprocess');
addpath('src/mlp');

digits = read_digits('training_data');
[tr, ts, v] = split_data(digits, 89, 10, 1);
[tr, trclass] = flatten(tr);
[ts, tsclass] = flatten(ts);
[v, vclass] = flatten(v);

% train network
maxEpochs = 10000;
hiddenNeurons = 10;
[wHidden, wOutput] = train_mlp(tr, trclass, maxEpochs, hiddenNeurons);

% save network to disk
save('network.mat', 'wHidden', 'wOutput');

% test classifier
n = length(ts);
c = zeros(n, 1);

for i = 1:n
    c(i) = classify_mlp(ts{i}, wHidden, wOutput);
end
err = sum(c ~= tsclass);
1 - err / length(tsclass)
