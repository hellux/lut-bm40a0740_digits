addpath('src/data');
addpath('src/preprocess');

digits = read_digits('training_data');
[digits, class] = flatten(digits);

texscale = '-S200,200';
dir = 'build/fig/';
f_merge = @(a, b) max(a, b);

% 103: double line 1
% 132: noisy 1
% 273: noisy 2
% 205: noisy 2 on upper curve
d = digits{205};

[dilated, rasterized, scaled] = preprocess(d);

figure('visible', 'off');
plot(scaled(:, 1), scaled(:, 2));
grid off;
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'xticklabel', {[]});
set(gca, 'yticklabel', {[]});
W = size(rasterized, 1);
axis([0 W, 0 W]);
print(strcat(dir, 'rasterize_0', '.tex'), '-dtex', texscale);

imwrite(rasterized, strcat(dir, 'rasterize_1.png'));
imwrite(dilated,    strcat(dir, 'rasterize_2.png'));
