addpath('src');
addpath('src/data');

digits = read_digits('training_data');
[testdata, testclass] = flatten(digits);

n = length(testdata);
c = zeros(n, 1);

for i = 1:n
    c(i) = digit_classify(testdata{i});
end
err = sum(c ~= testclass);
1 - err / length(testclass)
