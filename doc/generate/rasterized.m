addpath('src/data');
addpath('src/preprocess');
addpath('src');

digits = read_digits('training_data');
[digits, class] = flatten(digits);

texscale = '-S200,200';
W = 28;
dir = 'build/fig/';
f_merge = @(a, b) max(a, b);

% 103: double line 1
% 132: noisy 1
% 273: noisy 2
% 205: noisy 2 on upper curve
d = digits{205};

scaled = rescale(d, W-2);
rasterized = rasterize_wu(scaled, W-2, f_merge);
thick = thicken(rasterized);

figure('visible', 'off');
plot(scaled(:, 1), scaled(:, 2));
grid off;
set(gca, 'xtick', []);
set(gca, 'ytick', []);
set(gca, 'xticklabel', {[]});
set(gca, 'yticklabel', {[]});
axis([0 W, 0 W]);
print(strcat(dir, 'rasterize_0', '.tex'), '-dtex', texscale);

imwrite(rasterized, strcat(dir, 'rasterize_1.png'));
imwrite(thick,      strcat(dir, 'rasterize_2.png'));
