function s = tn(conf)
    n = size(conf, 1);
    s = sum(conf(:)) - tp(conf) - fn(conf) - fp(conf);
end
