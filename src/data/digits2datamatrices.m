% Separate labeled cell array of digit images to data and class matrices.
function [data, class] = imgs2trainmatrices(d)
    datas = cell(1, 0);
    class = zeros(0, 1);

    i = 0;
    for label = 0:9
        for j = 1:length(d{label+1})
            img = d{label+1}{j};
            i = i + 1;
            data(i, :) = img(:)';
            class(i) = label+1;
        end
    end

    data = data(1:i, :);
    class = class(1:i);
end
