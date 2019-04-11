clc;
close all;
clear all;
[x1, x2, x3, x4, x5,] = importdata('rankingcandidates.dat', 1, 240);
A = [x1 x2 x3 x4 x5];
B = fliplr(A);
names_array = {'HC','DT','BS','JK','TC'};
e = 0.8;
[m, n] = size(A);
Hillarysum = 0;
Donaldsum = 0;
Berniesum = 0;
JKsum = 0;
Tedsum = 0;
HC_BS = 0;
HC = ismember(A,'HC');%CREATE 1 AND 0 LOGICAL ARRAY
DT = ismember(A,'DT');
BS = ismember(A,'BS');
JK = ismember(A,'JK');
TC = ismember(A,'TC');
HCvsDT = 0;
HCvsBS = 0;
HCvsJK = 0;
HCvsTC = 0;
for i = 1:m %Find num of times candidate i win to j
    if find(HC(i,:) == 1) > find(DT(i,:) == 1)
        HCvsDT = HCvsDT +1;
    end
end
for i = 1:m
    if find(HC(i,:) == 1) > find(BS(i,:) == 1)
            HCvsBS = HCvsBS + 1;
    end
end
for i = 1:m
    if find(HC(i,:) == 1) > find(TC(i,:) == 1)
            HCvsTC = HCvsTC + 1; 
    end
end
for i = 1:m
    if find(HC(i,:) == 1) > find(JK(i,:) == 1)
            HCvsJK = HCvsJK + 1;
    end
end
        
BSvsHC = 0;
BSvsDT = 0;
BSvsJK = 0;
BSvsTC = 0;
for i = 1:m
    if find(BS(i,:) == 1) > find(DT(i,:) == 1)
        BSvsDT = BSvsDT +1;
    end
end
for i = 1:m
    if find(BS(i,:) == 1) > find(HC(i,:) == 1)
            BSvsHC = BSvsHC + 1;
    end
end
for i = 1:m
    if find(BS(i,:) == 1) > find(TC(i,:) == 1)
            BSvsTC = BSvsTC + 1; 
    end
end
for i = 1:m
    if find(BS(i,:) == 1) > find(JK(i,:) == 1)
            BSvsJK = BSvsJK + 1;
    end
end

DTvsHC = 0;
DTvsBS = 0;
DTvsJK = 0;
DTvsTC = 0;
for i = 1:m
    if find(DT(i,:) == 1) > find(BS(i,:) == 1)
        DTvsBS = DTvsBS +1;
    end
end
for i = 1:m
    if find(DT(i,:) == 1) > find(HC(i,:) == 1)
            DTvsHC = DTvsHC + 1;
    end
end
for i = 1:m
    if find(DT(i,:) == 1) > find(TC(i,:) == 1)
            DTvsTC = DTvsTC + 1; 
    end
end
for i = 1:m
    if find(DT(i,:) == 1) > find(JK(i,:) == 1)
            DTvsJK = DTvsJK + 1;
    end
end

TCvsHC = 0;
TCvsBS = 0;
TCvsJK = 0;
TCvsDT = 0;
for i = 1:m
    if find(TC(i,:) == 1) > find(BS(i,:) == 1)
        TCvsBS = TCvsBS +1;
    end
end
for i = 1:m
    if find(TC(i,:) == 1) > find(HC(i,:) == 1)
            TCvsHC = TCvsHC + 1;
    end
end
for i = 1:m
    if find(TC(i,:) == 1) > find(DT(i,:) == 1)
            TCvsDT = TCvsDT + 1; 
    end
end
for i = 1:m
    if find(TC(i,:) == 1) > find(JK(i,:) == 1)
            TCvsJK = TCvsJK + 1;
    end
end

JKvsHC = 0;
JKvsBS = 0;
JKvsTC = 0;
JKvsDT = 0;
for i = 1:m
    if find(JK(i,:) == 1) > find(BS(i,:) == 1)
        JKvsBS = JKvsBS +1;
    end
end
for i = 1:m
    if find(JK(i,:) == 1) > find(HC(i,:) == 1)
            JKvsHC = JKvsHC + 1;
    end
end
for i = 1:m
    if find(JK(i,:) == 1) > find(DT(i,:) == 1)
            JKvsDT = JKvsDT + 1; 
    end
end
for i = 1:m
    if find(JK(i,:) == 1) > find(TC(i,:) == 1)
            JKvsTC = JKvsTC + 1;
    end
end

for j= 1:m %sum num loss against other candidates
    for i = 1:n
        if (HC(j,i) == 0)
            Hillarysum = Hillarysum + 1;
        else if (HC(j,i) == 1)
                break
            end
        end
    end
end
for j= 1:m
    for i = 1:n
        if (DT(j,i) == 0)
            Donaldsum = Donaldsum + 1;
        else if (DT(j,i) == 1)
                break
            end
        end
    end
end
for j= 1:m
    for i = 1:n
        if (BS(j,i) == 0)
            Berniesum = Berniesum + 1;
        else if (BS(j,i) == 1)
                break
            end
        end
    end
end
for j= 1:m
    for i = 1:n
        if (JK(j,i) == 0)
            JKsum = JKsum + 1;
        else if (JK(j,i) == 1)
                break
            end
        end
    end
end
for j= 1:m
    for i = 1:n
        if (TC(j,i) == 0)
            Tedsum = Tedsum + 1;
        else if (TC(j,i) == 1)
                break
            end
        end
    end
end
%Create Stochastic Matrix
StochMat = [0, HCvsDT/Hillarysum, HCvsBS/Hillarysum, HCvsJK/Hillarysum, HCvsTC/Hillarysum;
   BSvsHC/Berniesum, BSvsDT/Berniesum, 0, BSvsJK/Berniesum, BSvsTC/Berniesum;
   DTvsHC/Donaldsum, 0, DTvsBS/Donaldsum, DTvsJK/Donaldsum, DTvsTC/Donaldsum;
   JKvsHC/JKsum, JKvsDT/JKsum, JKvsBS/JKsum, 0, JKvsTC/JKsum;
   TCvsHC/Tedsum, TCvsDT/Tedsum, TCvsBS/Tedsum,TCvsJK/Tedsum, 0];
StochasticM = StochMat'
%Perron-Forbenius eigenvector
Perron = e * StochasticM +((1-e)/n)*ones(n);
[P D] = eig(Perron);
NormPer =  P(:,1)'/sum(P(:,1));
answer = [names_array; num2cell(NormPer)];
Max = max(NormPer);
disp(answer);
for j=1:n
    if NormPer(j)==Max
        Winner = names_array(j);
    end
end
celldisp(Winner);


   
