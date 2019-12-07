function mat = confusion(x, y)
    N = max(max(x), max(y));
    mat = zeros(N, N);
    for i = 1:length(x)
        mat(y(i), x(i)) = mat(y(i), x(i)) + 1;
    end
end
