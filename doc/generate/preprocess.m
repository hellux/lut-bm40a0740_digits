addpath('src/data');
addpath('src/preprocess');

digits = read_digits('training_data');
[digits, class] = flatten(digits);

texscale = '-S180,180';
dir = 'build/fig/';
f_merge = @(a, b) max(a, b);

% 103: double line 1
% 132: noisy 1
% 273: noisy 2
% 205: noisy 2 on upper curve
d = digits{205};

mins = min(d);
maxs = max(d);
w = maxs(1)-mins(1);
h = maxs(2)-mins(2);
s = maxs(3)-mins(3);
W0 = max(w, h);
x_start = mins(1) - (W0-w)/2;
y_start = mins(2) - (W0-h)/2;
x_end = x_start + W0;
y_end = y_start + W0;
z_start = mins(1) - (W0-s)/2;
z_end = z_start + W0;

[dilated, rasterized, scaled] = preprocess(d);
W = size(rasterized, 1);

figure('visible', 'off');
plot3(d(:, 1), d(:, 3), d(:, 2));
axis([x_start x_end z_start z_end y_start y_end], 'square');
print(strcat(dir, 'preprocess_0', '.tex'), '-dtex', texscale);

figure('visible', 'off');
plot(d(:, 1), d(:, 2));
axis([x_start-20 x_end+20 y_start-20 y_end+20], 'square');
print(strcat(dir, 'preprocess_1', '.tex'), '-dtex', texscale);

figure('visible', 'off');
plot(scaled(:, 1), scaled(:, 2));
W = size(rasterized, 1);
axis([0 W, 0 W]);
print(strcat(dir, 'preprocess_2', '.tex'), '-dtex', texscale);

imwrite(rasterized, strcat(dir, 'preprocess_3.png'));
imwrite(dilated,    strcat(dir, 'preprocess_4.png'));
