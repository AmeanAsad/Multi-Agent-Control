function [matrix] = saved_file2mat(file_name)
% This function will make either a .mat into a usable Matlab matrix. The
% input to this is a string (so you need '' for the input).
matrix = load(file_name);
matrix = struct2cell(matrix);
matrix = cell2mat(matrix);
end