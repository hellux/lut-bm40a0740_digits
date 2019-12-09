% Turn a cell array of images into a matrix where each row is a list of
% pixels for a sample.
function data = imgs2trainmatrices(d)
    N = length(d);
    [a, b] = size(d{1});

    data = zeros(1000, a*b);
    for i = 1:N
        img = d{i};
        data(i, :) = img(:)';
    end

    data = data(1:i, :);
end
