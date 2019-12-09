function [wOutput, wHidden] = ...
  backpropagate(x, wHidden, wOutput, yHidden, yOutput, trainOutput)
    rho = 0.0001;

    deltaOutput = (yOutput-trainOutput);
    deltaHidden = (wOutput(1:end-1, :)*deltaOutput) .* ...
                  (1 - yHidden(1:end-1,:).^2);
    deltawHidden = -rho*x'*deltaHidden';
    deltawOutput = -rho*yHidden*deltaOutput';
    wOutput = wOutput + deltawOutput;
    wHidden = wHidden + deltawHidden;
end
