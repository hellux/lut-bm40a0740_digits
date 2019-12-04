function [wHidden, wOutput] = ...
  mlp(traindata, trainclass, maxEpochs, hidden)

    N = size(traindata, 1);
    d = size(traindata, 2);
    classes = max(trainclass);

    J = zeros(1, maxEpochs);

    rho = 0.0001;

    trainOutput = zeros(classes,N);
    for i = 1:N
        trainOutput(trainclass(i), i) = 1;
    end

    extendedInput = [traindata ones(N, 1)];

    wHidden = (rand(d+1, hidden) - 0.5) / 10;
    wOutput = (rand(hidden+1, classes) - 0.5) / 10;

    t = 0;
    while 1
        t = t + 1;

        [yOutput, yHidden] = feedforward(extendedInput, wHidden, wOutput);

        J(t) = sum(sum((yOutput-trainOutput).^2))/2;

        if (J(t) < 1e-12)
            break;
        end

        if (t >= maxEpochs)
            break;
        end

        if t > 1
            if abs(J(t) - J(t-1)) < 1e-12
                break;
            end
        end

        deltaOutput = (yOutput-trainOutput);
        deltaHidden = (wOutput(1:end-1, :)*deltaOutput) .* ...
                      (1 - yHidden(1:end-1,:).^2);

        deltawHidden = -rho*extendedInput'*deltaHidden';
        deltawOutput = -rho*yHidden*deltaOutput';
        wOutput = wOutput + deltawOutput;
        wHidden = wHidden + deltawHidden;
    end
end
