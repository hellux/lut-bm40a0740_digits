function [wHidden, wOutput] = train_mlp(raw, trainclass, maxEpochs, hiddenNeurons)
    fprintf('preprocessing data.. ');
    N = length(raw);
    processed = cell(1, N);
    for i = 1:N
        processed{i} = preprocess(raw{i});
    end
    disp('done.');

    fprintf('running MLP.. ');
    traindata = imgs2trainmatrices(processed);
    [wHidden, wOutput] = mlp(traindata, trainclass, maxEpochs, hiddenNeurons);
    disp('done.');
end
