% Flatten a cell array of digit sets to a merged set with accompanying labels
% in a separate vector.
function [flat, class] = flatten(digits)
    flat = cell(1, 0);
    class = zeros(0, 1);

    for i = 1:length(digits)
        samples = digits{i};
        n = size(samples, 2);
        class = [class; i*ones(n, 1)];
        flat = [flat samples];
    end
end
