% Separate labeled cell array of digit images to data and class matrices.
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
