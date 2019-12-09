% true positive rate, i.e sensitivity
function y = tpr(conf)
    tp0 = tp(conf);
    fn0 = fn(conf);
    y = tp0 / (tp0 + fn0);
end
