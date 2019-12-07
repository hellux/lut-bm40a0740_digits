% read labeled digits located in dirpath
function digits = read_digits(dirpath)
    digits = {};
    for i = 0:9
        path = strcat(dirpath, '/stroke_', int2str(i), '_*.mat');
        f = @(x) load(strcat(x.folder, "/", x.name));
        digits{end+1} = struct2cell(arrayfun(f, dir(path)));
    end
end
