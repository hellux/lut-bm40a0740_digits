function c = digit_classify(testdata)
    if ~exist('network')
        addpath('src/preprocess');
        addpath('src/mlp');

        % load network from disk, consisting of weights: wHidden, wOutput
        load("network.mat");
    end

    c = classify_mlp(testdata, wHidden, wOutput);
end
