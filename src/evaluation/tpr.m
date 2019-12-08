% true positive rate, i.e sensitivity
function y = tpr(conf)
    tp = tp(conf);
    fn = fn(conf);
    y = tp / (tp + fn);
end
