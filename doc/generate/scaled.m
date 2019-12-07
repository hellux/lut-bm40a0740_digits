addpath('src/data');
addpath('src/preprocess');
addpath('src');

digits = read_digits('training_data');
digits = {digits{7}}; % pick only sixes
[digits, class] = flatten(digits);
digits = digits(:, [31 35]);

mins = digits{1};
maxs = digits{1};
for i = 1:length(digits)
    mins = min(mins, min(digits{i}));
    maxs = max(maxs, max(digits{i}));
end
mins = mins(1, :)-20;
maxs = maxs(1, :)+20;
W0 = max(maxs-mins);
texscale = '-S200,200';
dir = 'build/fig/';

for i = 1:length(digits)
    d = digits{i};
    W = 28;

    scaled = rescale(d, W-2);
    suffix = strcat(int2str(i), '.tex');

    figure('visible', 'off');
    plot(d(:, 1), d(:, 2));
    axis([mins(1) mins(1)+W0 mins(2) mins(2)+W0], 'square');
    print(strcat(dir, 'scale_before', suffix), '-dtex', texscale);

    figure('visible', 'off');
    plot(scaled(:, 1), scaled(:, 2));
    axis([0 W 0 W], 'square');
    print(strcat(dir, 'scale_after', suffix), '-dtex', texscale);
end
