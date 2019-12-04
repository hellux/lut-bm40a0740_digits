function c = classify_mlp(data, wHidden, wOutput)
    N = size(data, 1);
    processed = preprocess(data);
    extendedInput = [processed(:)' 1];
    yOutput = feedforward(extendedInput, wHidden, wOutput); 

    [~, c] = max(yOutput, [], 1);
end
