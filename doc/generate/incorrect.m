addpath('src/data');
addpath('src/preprocess');

load('result_save.mat');

pkg load symbolic;
setenv PYTHON python2;
latex(sym(conf))

digits = read_digits('training_data');
[digits, class] = flatten(digits);

W = 20;
dir = 'build/fig/';
f_merge = @(a, b) max(a, b);

figure('visible', 'off');
n = length(incorrect);
cols = 4;
for j = 1:n
    i = incorrect(j);
    d = digits{vidx(i)};

    scaled = rescale(d, W-2);
    subplot(ceil(n/cols), cols, j);

    plot(scaled(:, 1), scaled(:, 2));
    grid off;
    set(gca, 'xtick', []);
    set(gca, 'ytick', []);
    set(gca, 'xticklabel', {[]});
    set(gca, 'yticklabel', {[]});
    axis([0 W, 0 W], 'square');
    g = cstrcat('guess: ', int2str(guesses(i)-1));
    a = cstrcat('actual: ', int2str(actual(i)-1));
    title(cstrcat(g, ', ', a));
end

print(strcat(dir, 'incorrect', '.tex'), '-dtex');
