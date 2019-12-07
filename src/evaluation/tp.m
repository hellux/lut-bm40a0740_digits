function s = tp(conf)
    n = size(conf, 1);
    s = 0;
    for i = 1:n
        s = s + conf(i, i);
    end
    s = s / n;
end
