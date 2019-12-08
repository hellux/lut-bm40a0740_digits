function [yOutput, yHidden] = feedforward(x, wHidden, wOutput)
    vHidden = wHidden'*x';
    yHidden = tanh(vHidden);

    N = size(yHidden, 2);
    yHidden = [yHidden; ones(1, N)];

    vOutput = wOutput'*yHidden;
    yOutput = vOutput;
end
