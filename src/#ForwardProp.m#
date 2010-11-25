%sets up weight matricies
function[P] =  ForwardProp(M,P)

fprintf('forward prop..\n');
net = cell(M.nLayers,1);
for i=1:M.nLayers-1
  net{i} = P.a{i}*P.w{i};

  if strcmp(M.sigma, 'tanh')
    P.a{i+1} = tanh(net{i});
  else
    P.a{i+1} = 1./(1+exp(-net{i}));
  end
  % if not the end and bias, need to reset the last row of a{i+1} to 1
  if M.bias && i~=M.nLayers-1
    P.a{i+1}(:,end) = ones(size(P.a{i+1},1) ,1);
  end    

end
