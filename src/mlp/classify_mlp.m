function c = classify_mlp(data, wHidden, wOutput)
    N = size(data, 1);
    processed = preprocess(data);
    x = [processed(:)' 1];
    yOutput = feedforward(x, wHidden, wOutput);

    [~, c] = max(yOutput, [], 1);
end
