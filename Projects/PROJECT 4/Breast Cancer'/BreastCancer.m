clc;
clear all;
close all;
[train,test,ntrain,ntest]=ReadWDBC('wdbc.data',30);
Malignant=[];
Benign=[];
T = [];
M = [];
MinValue = [];
for i = 1:ntrain
    if(train(i,1)==0)
        Benign = [Benign;train(i,2:end)]; %Create Benign 
    elseif(train(i,1)==1)
        Malignant = [Malignant;train(i,2:end)]; %Create malignant.
    end
end
m = size(Malignant,1);
k = size(Benign,1);
e_m = ones(m,1);%unit e_m vector
e_k = ones(k,1);%unit e_k vector
lambda = [0.001 0.01 0.1 1 10];
for i = 1:5
    l = lambda(i);
cvx_begin quiet%optimize SVM classification
    variable w(30)
    variable Y(1)
    variable y(m)%binary M
    variable z(k)%binary B
    minimize((1/m)*e_m'*y + (1/k)*e_k'*z + (l/2)*w'*w)
    subject to
    Malignant*w - e_m*Y +y >= e_m
    -Benign*w + e_k*Y+z >= e_k
    y >= 0
    z >= 0
cvx_end
T(:,i) = w; %make table take hyperplane
U(i) = Y; %make table take Y
MinValue(i) = cvx_optval;
end
BenignT = [];
MalignantT = [];
for i = 1:ntest
    if(test(i,1)==0)
        BenignT = [BenignT;test(i,2:end)];
    elseif(test(i,1)==1)
        MalignantT = [MalignantT;test(i,2:end)];
    end
end
for j = 1:5
MisClassifiedPoints = 0;
ma = size(MalignantT,1);
be = size(BenignT,1);
e_mm = ones(ma,1);
e_kk = ones(be,1);
w = T(:,j);%find mismatches for each hyperplane
Y = U(j);
a = MalignantT*w - e_mm *Y;
b = BenignT*w - e_kk *Y;
for i = 1:ma
    if(a(i) <= 0)
        MisClassifiedPoints = MisClassifiedPoints+1;
    end
end
for i = 1:be
    if(b(i)>0)
        MisClassifiedPoints = MisClassifiedPoints+1;
    end
end
M(j) = MisClassifiedPoints;%store mismatches
end

colNames = {'sigma0_001','sigma0_01','sigma0_1','sigma_1','sigma10'};
sTable = array2table(T,'VariableNames',colNames);
MisClassified_Points = array2table(M,'VariableNames',colNames);
Optimal_Value_LP = array2table(MinValue,'VariableNames',colNames);
display(sTable);
display(Optimal_Value_LP);
display(MisClassified_Points);



