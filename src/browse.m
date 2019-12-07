addpath('src/data');
addpath('src/preprocess');

digits = read_digits('training_data');
[digits, class] = flatten(digits);

mins = digits{1};
maxs = digits{1};
for i = 1:length(digits)
    mins = min(mins, min(digits{i}));
    maxs = max(maxs, max(digits{i}));
end
mins = mins(1, :)-20;
maxs = maxs(1, :)+20;
W0 = max(maxs-mins);
W = 28;
f_merge = @(a, b) max(a, b);

for i = randperm(100, 20)+100;
    d = digits{i};

    scaled = rescale(d, W-2);

    header = strcat('i: ', int2str(i), ', digit: ', int2str(class(i)-1));
    figure;
    subplot(1, 2, 1); plot(d(:, 1), d(:, 2));
    title(header, 'fontsize', 20);
    axis([mins(1) mins(1)+W0 mins(2) mins(2)+W0], 'square');

    subplot(1, 2, 2); plot(scaled(:, 1), scaled(:, 2));
    axis([0 W 0 W], 'square');
end

pause;
