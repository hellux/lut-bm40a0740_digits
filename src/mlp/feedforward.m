function [yOutput, yHidden] = feedforward(extendedInput, wHidden, wOutput)
    vHidden = wHidden'*extendedInput';
    yHidden = tanh(vHidden);

    N = size(yHidden, 2);
    yHidden = [yHidden; ones(1, N)];

    vOutput = wOutput'*yHidden;
    yOutput = vOutput;
end
