clc;
close all;
clear all;
Q = importexamscores('examscores.dat', 1, 31);
[row col] = size(Q);
N = zeros(col);
D = 0;
diff = 0;
Y_k(1:col) = 0;
sum = 1;
for i = 1:row%Create 1,-1 matrix for Q_b>Q_a
    for j = 1:col
        for k = 1:col
            if Q(i,j)>Q(i,k)
             N(sum,j) = 1;
             N(sum,k) = -1;
             diff = Q(i,j)-Q(i,k);
             D(sum) = diff;
             sum = sum + 1;
            end
        end
    end
end
D = D';
[row1 col1] = size(N);
for i = 1:row1%Create Y with actual difference Q_b-Q_a
    for j = 1:col1
        if N(i,j) == 1
        Y_k(j) = Y_k(j) + D(i);
        end
    end
end
Y = Y_k';
X = N'*N;
AX_Y = [N D];% Matrix Ar=y
X(end,:) = 1%add 1 last row
Y(end,:) = 0 % add 0 las row
result = linsolve(X,Y); %Solve Ar = y 
results_array = result';
names_array = {'Q1','Q2', 'Q3','Q4','Q5','Q6','Q7'};
answer = [names_array; num2cell(results_array)];
disp(answer);
Min = min(results_array);
for j=1:col
    if results_array(j)==Min
        Hardest = names_array(j);
    end
end
celldisp(Hardest);
