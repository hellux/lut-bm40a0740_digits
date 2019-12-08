function [wHiddenFinal, wOutputFinal, hiddenFinal, f1Max] = train_mlp(raw, trainclass, valdata, valclass)
    fprintf('preprocessing data.. ');
    N = length(raw);
    processed = cell(1, N);
    for i = 1:N
        processed{i} = preprocess(raw{i});
    end
    disp('done.');
    traindata = imgs2trainmatrices(processed);

    maxEpochs = 1000;
    wHiddenFinal = [];
    wOutputFinal = [];
    f1Max = 0;
    hiddenFinal = 0;
    for hiddenNeurons = 10:1:30
        fprintf('running MLP.. ');
        [wHidden, wOutput] = mlp(traindata, trainclass, maxEpochs, hiddenNeurons);
        disp('done.');

        fprintf('evaluating MLP.. ');
        conf = evaluate_mlp(wHidden, wOutput, valdata, valclass);
        f1 = f1_score(conf);
        if f1 > f1Max
            wHiddenFinal = wHidden;
            wOutputFinal = wOutput;
            f1Max = f1
            hiddenFinal = hiddenNeurons
        end

        disp('done.');
    end
end
