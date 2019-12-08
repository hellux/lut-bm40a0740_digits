% true negative rate, i.e specificity
function y = tnr(conf)
    tn = tn(conf);
    fp = fp(conf);
    y = tn / (tn + fp);
end
