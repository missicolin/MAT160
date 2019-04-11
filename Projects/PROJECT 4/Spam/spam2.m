clc;
clear all;
close all;
x = load('spambase.data');
names = fopen('namesspam.txt','r');
dataArray = textscan(names,'%s%[^\n\r]');
namesspan = dataArray(:,1);
Y = x(:,58); %read nominal class label
X = x(:,1:57); %read attributes
[m,n] = size(X)
[m,v] = size(Y)

T = [];
lambda =1; 
for i = 1:5
cvx_begin quiet% LASSO implementation
    variable w(n);
    minimize norm(Y-X*w,2) + lambda * norm(w,1);
    %subject to
    %norm(w,1) <= lambda;  LASSO (2) example
cvx_end
T(:,i) = w;
lambda = lambda + 2*i; %Try diffent values for lambda 
end

Z = abs(T);
for i= 1:n
 Rowsum(i,1) = sum(Z(i,:));
end
T(:,6) = Rowsum;
Total = array2table(T,...
    'VariableNames',{'lamda1','lamda3','lamda5','lamda7','lamda9','AbsSum'},...
    'RowNames',namesspan{:});
Total = sortrows(Total,6, 'descend')