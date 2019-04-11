clc;
close all;
clear all;
x = dlmread('winesinfo.csv',';',1,0);
y = x(:,12); %Read chemical properties
x = x(:,1:11); %Read score
[m,n] = size(x);
rowNames ={'fixedAcidity','volatileAcidity','citricAcid','residualSugar','chlorides','freeSulfurDioxide','totalSulfurDioxide','density','pH','sulphates','alcohol','OptimalValue'};
t = [];
LA = [];
disp('Part b) using 1-norm')
for i = 1:11
cvx_begin quiet
    variable w2(n);
    variable b;
    minimize(norm(x*w2 + b -y,1));
cvx_end
w2(12) = cvx_optval;
T(:,2) = w2;
end
HyperplaneW2 = array2table(w2,'RowNames',rowNames);
display(HyperplaneW2);
disp('Part 2b) least squares regression')
for i = 1:11
cvx_begin quiet
    variable w3(n);  
    variable b;
    minimize(norm(x*w3 +b - y,2));    
cvx_end
w3(12) = cvx_optval;
T(:,3) = w3;
end
HyperplaneW3 = array2table(w3,'RowNames',rowNames);
display(HyperplaneW3);
disp('Part 2b) LASSO Model')
lambda = 1;
for i = 1:5
cvx_begin quiet% LASSO implementation
    variable w4(n);
    variable b;
    minimize norm(y-x*w4+b,2) + lambda * norm(w4+b,1);
cvx_end
w4(12) = cvx_optval;
LA(:,i) = w4;
lambda = lambda + 2*i; %Try diffent values for lambda 
end
Z = abs(LA);
for i= 1:12
 Rowsum(i,1) = sum(Z(i,:));
end
LA(:,6) = Rowsum;
Total = array2table(LA,...
    'VariableNames',{'lamda1','lamda3','lamda5','lamda7','lamda9','AbsSum'},...
    'RowNames',rowNames);
HyperplanesW4 = sortrows(Total,6, 'descend')
display('Top 4 Features For deciding quality of wines as shown in the table are')
for i = 2:5
display(HyperplanesW4(i,6));
end