addpath('src/data');
addpath('src/preprocess');
addpath('src/mlp');
addpath('src/evaluation');

fprintf('loading data.. ');
digits = read_digits('training_data');
[tr, ts, v] = split_data(digits, 75, 25, 0);
[tr, trclass] = flatten(tr);
[ts, tsclass] = flatten(ts);
[v, vclass] = flatten(v);
disp('done.');

% train network
maxEpochs = 10000;
hiddenNeurons = 10;
[wHidden, wOutput] = train_mlp(tr, trclass, maxEpochs, hiddenNeurons);

% save network to disk
save('network.mat', 'wHidden', 'wOutput');

fprintf('testing classifier..');
n = length(ts);
c = zeros(n, 1);
for i = 1:n
    c(i) = classify_mlp(ts{i}, wHidden, wOutput);
end
con = confusion(tsclass, c)
f1_score(con)
disp('done.');

%pkg load symbolic;
%setenv PYTHON python2;
%latex(sym(con));
