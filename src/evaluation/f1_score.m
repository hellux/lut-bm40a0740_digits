function y = f1_score(conf)
    tp0 = tp(conf);
    fp0 = fp(conf);
    fn0 = fn(conf);
    y = 2 * tp0 / (2*tp0 + fp0 + fn0);
end
