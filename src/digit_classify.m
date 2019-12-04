function c = digit_classify(testdata)
    addpath('src/preprocess');
    addpath('src/mlp');

    load("network.mat");

    c = classify_mlp(testdata, wHidden, wOutput);
end
