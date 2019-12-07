% true positive rate, i.e sensitivity
function y = f1_score(conf)
    tp = tp(conf);
    fp = fp(conf);
    fn = fn(conf);
    y = 2 * tp / (2*tp + fp + fn);
end
