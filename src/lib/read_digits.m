% read labeled digits located in dirpath
function digits = read_digits(dirpath)
    digits = cell(1, 10);
    for i = 0:9
        path = strcat(dirpath, '/stroke_', int2str(i), '_*.mat');
        f = @(x) load(strcat(x.folder, "/", x.name));
        digits{i+1} = struct2cell(arrayfun(f, dir(path)));
    end
end
