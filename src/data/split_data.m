function [train, test, val] = split_data(data, p_train, p_test, p_val)
    m = length(data);
    total = p_train+p_test+p_val;
    split1 = p_train/total;
    split2 = (p_train+p_test)/total;

    train = cell(1, m);
    test = cell(1, m);
    val = cell(1, m);
    for i = 1:m
        n = length(data{i});
        indices = randperm(n);
        split1n = floor(split1*n);
        split2n = floor(split2*n);

        train{i} = data{i}(1, indices(1:split1n));
        test{i}  = data{i}(1, indices(split1n+1:split2n));
        val{i}   = data{i}(1, indices(split2n+1:end));
    end
end
