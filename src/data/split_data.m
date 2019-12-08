function [set1, set2, idx1, idx2] = split_data(data, p1, p2)
    m = length(data);
    split = p1/(p1+p2);

    set1 = cell(1, m);
    set2 = cell(1, m);
    idx1 = [];
    idx2 = [];
    j = 1;
    for i = 1:m
        n = length(data{i});
        splitn = floor(split*n);

        indices = randperm(n);
        indices1 = indices(1:splitn);
        indices2 = indices(splitn+1:end);

        set1{i} = data{i}(1, indices1);
        set2{i} = data{i}(1, indices2);
        idx1 = [idx1 indices1+j];
        idx2 = [idx2 indices2+j];

        j = j + n;
    end
end
