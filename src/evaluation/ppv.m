% positive predictive value, i.e precision
function y = ppv(conf)
    tp0 = tp(conf);
    fp0 = fp(conf);
    y = tp0 / (tp0 + fp0);
end
