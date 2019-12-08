addpath('src/data');
addpath('src/preprocess');
addpath('src/mlp');
addpath('src/evaluation');

fprintf('loading data.. ');
digits = read_digits('training_data');
[tr, v, ~, vidx] = split_data(digits, 80, 20);
[traindata, trainclass] = flatten(tr);
[valdata, valclass] = flatten(v);
disp('done.');

% train network
maxEpochs = 10000;
hiddenNeurons = 10;
[wHidden, wOutput] = train_mlp(traindata, trainclass, ...
                               maxEpochs, hiddenNeurons);

% save network to disk
save('network.mat', 'wHidden', 'wOutput');

fprintf('testing classifier..');
n = length(valclass);
c = zeros(n, 1);
for i = 1:n
    c(i) = classify_mlp(valdata{i}, wHidden, wOutput);
    if c(i) ~= valclass(i)
        incorrect(end+1) = i;
    end
end

conf = confusion(valclass, c)
f1 = f1_score(conf)
tpr = tpr(conf)
tnr = tnr(conf)
ppv = ppv(conf)

% save results to disk
guesses = c;
actual = valclass;
save('result.mat', 'incorrect', 'vidx', 'conf', 'guesses', 'actual');

disp('done.');

