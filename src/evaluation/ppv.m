% positive predictive value, i.e precision
function y = ppv(conf)
    tp = tp(conf);
    fp = fp(conf);
    y = tp / (tp + fp);
end
