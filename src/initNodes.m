%sets up weight matricies
function[Params] =  initNodes(Model, Params, data)
layers = Model.arch;
fprintf('init nodes\n');
%set up activation nodes's
if Model.bias %add extra ones
  Params.a{1} = [data ones(Model.nExamples, 1)];
else
  Params.a{1} = [data];
end
for i=2:Model.nLayers
  if Model.bias
    Params.a{i} = zeros(Model.nExamples,layers(i)+1);
  else
    Params.a{i} = zeros(Model.nExamples, layers(i));
  end
end
