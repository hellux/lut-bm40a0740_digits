clc;
clearvars;
close all hidden;
addpath([pwd '\training_data']);
data = cell(1, 10);
for i = 0:9
    data{i + 1} = struct2cell(arrayfun(@(x) load(x.name), dir("training_data\stroke_" + i + "_*.mat")));
end
clear i;

color = [0, 0, 0;
        0.5, 1, 1;
        1, 0.5, 1;
        1, 1, 0.5;
        0.5, 0.5, 1;
        0.5, 1, 0.5;
        1, 0.5, 0.5;
        0, 0, 1;
        0, 1, 0;
        1, 0, 0;];
    
f1 = figure("Name", "Mean");
hold on;
legend;
f2 = figure("Name", "Var");
hold on;
legend;
m = zeros(3, 100);
v = m;
dataN = data;
for i = 0:9
    for j = 1:100
        [dataN{i + 1}{j}, m(:, j), v(:, j)] = Normalize(data{i + 1}{j});
    end
    figure(f1);
    plot(m(1, :), m(2, :), 'Color', color(i + 1, :), 'LineStyle', 'none', 'Marker', '*', 'DisplayName', int2str(i));
    figure(f2);
    plot(v(1, :), v(2, :), 'Color', color(i + 1, :), 'LineStyle', 'none', 'Marker', '*', 'DisplayName', int2str(i));
end
clear i j m v f1 f2;

function [data, m, v] = Normalize(data)
    n = size(data, 2);
    for i = 1:n
        data(:, i) = normalize(data(:, i), "range", [-1, 1]);
    end
    m = mean(data);
    v = var(data);
end