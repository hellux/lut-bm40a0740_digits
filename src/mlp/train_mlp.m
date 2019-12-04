function [wHidden, wOutput] = train_mlp(raw, trainclass, maxEpochs, hiddenNeurons)
    N = length(raw);
    processed = cell(1, N);
    for i = 1:N
        processed{i} = preprocess(raw{i});
    end

    traindata = imgs2trainmatrices(processed);
    [wHidden, wOutput] = mlp(traindata, trainclass, maxEpochs, hiddenNeurons);
end
