%computes delta for each weight to update by back propagating erros
%dw has the same structures as weights (cell array of nLayers-1)
function[dw] = BackProp(M, P, dw, err)

fprintf('backprop..\n');
delta = err.*sigmaPrime(M, P, P.a{end});

for i=M.nLayers-1:-1:1
  dw{i} =P.a{i}'*delta;
  %update delta
  % newDelta = Sum(OldDelta*Weight_i
  %sumDeltaWeights = delta*P.w{i}';
%  newprime = sigmaPrime(M, P, P.a{i});
  delta =sigmaPrime(M, P, P.a{i}).* (delta*P.w{i}');
end


end%of function backprop

function[a] = sigmaPrime(M, P, a)
  if strcmp(M.sigma, 'tanh')
    a = 1-a.^2;
  else 
    a = (1-a).*a;
  end

end
