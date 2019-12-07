addpath('src/data');
addpath('src/preprocess');
addpath('src');

digits = read_digits('training_data');
digits = {digits{7}}; % pick only sixes
[digits, class] = flatten(digits);

texscale = '-S200,200';
W = 28;
dir = 'build/fig/';
f_merge = @(a, b) max(a, b);

d = digits{31};

scaled = rescale(d, W-2);
rasterized = rasterize_wu(scaled, W-2, f_merge);
thick = thicken(rasterized);

figure('visible', 'off');
plot(scaled(:, 1), scaled(:, 2));
axis([0 W, 0 W]);
print(strcat(dir, 'rasterize_0', '.tex'), '-dtex', texscale);

% TODO build octave with image IO
%imwrite(rasterized, 'rasterize_1.png');
%imwrite(thick, strcat(dir, 'rasterize_2.png'));
