% true negative rate, i.e specificity
function y = tnr(conf)
    tn0 = tn(conf);
    fp0 = fp(conf);
    y = tn0 / (tn0 + fp0);
end
