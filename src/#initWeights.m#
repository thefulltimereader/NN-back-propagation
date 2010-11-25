%sets up weight matricies
function[Params] =  initWeights(Model, Params)

fprintf('init weights\n');
layers = Model.arch;
%set up weights with normally dist random numbers between -1 and 1
% (if bias add an extra row for it in the bottom)
for i = 1: Model.nLayers-2
%if bias, add 1 extra row
 if(Model.bias) 
   Params.w{i} = [1-2*randn(layers(i)+1, layers(i+1)+1)];
 else
   Params.w{i} = [1-2*randn(layers(i), layers(i+1))];
 end
end

if(Model.bias)
  Params.w{end} = [1-2*randn(layers(end-1)+1, layers(end))];
else
  Params.w{end} = [1-2*randn(layers(end-1), layers(end))];
end

