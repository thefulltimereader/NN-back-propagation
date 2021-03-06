
% data is N by M matrix where N = number of examples
% M = vector input (first input nodes)
% expected is N by nOutput matrix where each row entries corresponds to
% the expected output of each row in N

function [data, expected] = readData(fName, Model)
fprintf('reading data...\n');
%readin text file 
fid = fopen(fName);
data = fscanf(fid, '%f', [Model.nExamples, Model.nInput]);
expected = fscanf(fid, '%f', [Model.nExamples, Model.nOutput]);
fclose(fid);

%dummy data
%data = randi(2, Model.nExamples, Model.nInput)-1;
%expected = randn( Model.nExamples, Model.nOutput);
