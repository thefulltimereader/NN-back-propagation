function[Params, Model, DATA, EXPECTED] = do_all()
close all;
%Configuration file that sets up model and parameters%
%number of nodes in each layer
Model.arch =[100 150 60 1];
Model.nLayers = length(Model.arch);
Model.nOutput = Model.arch(end);
Model.nInput = Model.arch(1);
Model.nExamples = 130;
Model.bias = true;
%when to stop
Model.expectedMSE = 0.01;
Model.maxIts = 50000000;
%stepsize
Model.step = 0.01;
%nonlinearities function: tanh or sigmoid
Model.sigma = 'tanh'; 
RUN_DIR = [ '/misc/FergusGroup/ajk377/VoronoiBP/'];

Model.fName = '/data';

Params.w = cell(Model.nLayers-1,1);
Params.a = cell(Model.nLayers,1);
if(Model.bias)
 Params.b = cell(Model.nLayers-1, 1);
end

if(exist([RUN_DIR Model.fName]));
  [DATA, EXPECTED] = readData([RUN_DIR Model.fName], Model);
else
 error('data file DNE');
end



%wanted to do this but matlab won't let me
%try
%  eval(config_file);
%catch error('config file DNE');
%end

%initialize
Params = initWeights(Model, Params);
Params = initNodes(Model, Params, DATA);

fprintf('init dw\n');
%set up dw, weight changes
dw = cell(Model.nLayers-1, 1);
for i=1:Model.nLayers-1
  dw{i} = zeros(size(Params.w{i}));
end


mse = Model.expectedMSE + 100;
its = 0;
%*****start iteration******
while mse > Model.expectedMSE && its < Model.maxIts
  %batch forward
  Params = ForwardProp(Model, Params);
  % difference(bare error) in output
  err = EXPECTED - Params.a{end};
  %get sum of squared 1/2*(E - t)^2
  sse = sum(0.5*(EXPECTED-Params.a{end}).^2);  
  dw = BackProp(Model, Params, dw, err);
  %update!
  for i=1:Model.nLayers-1
      %figure; plot(Params.w{i});hold on;
      Params.w{i} = Params.w{i} + Model.step*(dw{i}./Model.nExamples);
     % plot(Params.w{i}); hold off;
  end
 % fprintf('err is %d sse is %d ', err, sse);
  its=its+1;
  mse = sse/Model.nExamples;
  fprintf('mean squared error here is %.12f\n', mse);
%  if mod(its, 20000) == 0
%    plotExpectedVSOutput(EXPECTED, Params.a{end}, mse, its)
 % end
end

    plotExpectedVSOutput(EXPECTED, Params.a{end}, mse, its)

end 

function plotExpectedVSOutput(E, O, mse, its)
  fprintf('plot ');
  figure;
  plot(E, 'b.'); hold on;
  plot(O, 'r.'); 
  title(['Expected vs Output at iteration:',num2str(its), [' with ' ...
                      'mse:'],num2str(mse, '%.15f')]);
 legend('Expected', 'Output');

  hold off;

end
