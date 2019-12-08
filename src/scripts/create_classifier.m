addpath('src/data');
addpath('src/preprocess');
addpath('src/mlp');
addpath('src/evaluation');

fprintf('loading data.. ');
digits = read_digits('training_data');
[ts, tr, tidx] = split_data(digits, 2, 8);
[tr, v] = split_data(tr, 7, 1);
[traindata, trainclass] = flatten(tr);
[valdata, valclass] = flatten(v);
[testdata, testclass] = flatten(ts);
disp('done.');

% train network
[wHidden, wOutput, hidden, f1_val] = ...
    train_mlp(traindata, trainclass, valdata, valclass);

% save network to disk
save('network.mat', 'wHidden', 'wOutput');

fprintf('testing classifier..');
[conf, c] = evaluate_mlp(wHidden, wOutput, testdata, testclass);

incorrect = [];
for i = 1:length(c)
    if c(i) ~= testclass(i)
        incorrect(end+1) = i;
    end
end

f1 = f1_score(conf)
tpr = tpr(conf)
tnr = tnr(conf)
ppv = ppv(conf)

% save results to disk
guesses = c;
actual = testclass;
save('result.mat', 'incorrect', 'tidx', 'conf', ...
     'guesses', 'actual', 'hidden', 'f1_val');

disp('done.');

