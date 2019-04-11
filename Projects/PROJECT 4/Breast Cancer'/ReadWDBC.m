
function [train,test,ntrain,ntest] = ReadWDBC(datafile,dataDim)
fp = fopen(datafile,'r');
samples = 0;
train = zeros(0,dataDim+1);
[id,count] = fscanf(fp,'%d,',1);
while (count == 1) %Read if B or M and Convert to 1 and 0
  samples = samples + 1;
  type = fscanf(fp,'%1s',1);
  if type=='B'
    type =0;
  elseif type=='M'
    type =1;
  end
  vec = fscanf(fp,',%e',dataDim);
  train = [train; type vec'];
  [id,count] = fscanf(fp,'%d,',1);
end
test  = train(501:samples,:);%Create size 69 testing Set
train = train(1:500,:);%Create size 500 training Set
ntrain = size(train); 
ntest = size(test);
return;