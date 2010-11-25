%Configuration file that sets up model and parameters%
%number of nodes in each layer
Model.arch =[10 2];
Model.nLayers = length(Model.arch);
Model.nOutput = 1;
Model.nInput = 10;
Model.nExamples = 100;
%tanh or sigmoid
Model.nonlinearities = 'tanh'; 
RUN_DIR = [ '/misc/FergusGroup/ajk377/VoronoiBP/'];

Model.fName = '/data';

Params.weights = cell(Model.nLayers-1,1);

if(exist([RUN_DIR Model.fName]));
  [DATA, EXPECTED] = readData([RUN_DIR Model.fName]);
else
 error('data file DNE');
end


