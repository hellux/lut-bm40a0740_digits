function [wHidden, wOutput] = ...
  mlp(traindata, trainclass, maxEpochs, hiddenNeurons)
    ERR_THRESH = 1e-12;
    ERR_CHANG_THRESH = 1e-12;

    N = size(traindata, 1); % Number of samples
    d = size(traindata, 2); % Number of dimensions per sample
    classcount = max(trainclass);

    % Wanted output layers.
    trainOutput = zeros(classcount, N);
    for i = 1:N
        trainOutput(trainclass(i), i) = 1;
    end

    % Extend input layer with bias.
    x = [traindata ones(N, 1)];

    % Set random initial weights.
    wHidden = (rand(d+1, hiddenNeurons) - 0.5) / 10;
    wOutput = (rand(hiddenNeurons+1, classcount) - 0.5) / 10;

    err_prev = 0;
    for t = 1:maxEpochs
        [yOutput, yHidden] = feedforward(x, wHidden, wOutput);
        [wOutput, wHidden] = backpropagate(x, wHidden, wOutput,
                                              yHidden, yOutput, trainOutput);

        err = sum(sum((yOutput-trainOutput).^2))/2;
        if err < ERR_THRESH || (t > 1 && abs(err-err_prev) < ERR_CHANG_THRESH)
            break;
        end
        err_prev = err;
    end
end
