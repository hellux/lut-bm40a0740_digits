function [conf, c] = evaluate_mlp(wHidden, wOutput, testdata, testclass)
    n = length(testclass);
    c = zeros(n, 1);
    for i = 1:n
        c(i) = classify_mlp(testdata{i}, wHidden, wOutput);
    end

    conf = confusion(testclass, c);
end
