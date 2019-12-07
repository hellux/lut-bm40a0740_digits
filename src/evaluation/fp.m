function s = fp(conf)
    n = size(conf, 1);
    s = 0;
    for i = 1:n
        s = s + sum(conf(i, :)) - conf(i, i);
    end
    s = s / n;
end
