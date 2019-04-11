clc;
close all;
clear all;
[x1 x2 x3 x4 x5] = importdata('rankingcandidates.dat', 1, 240);
A = [x1 x2 x3 x4 x5];
[m n] = size(A);
Hillary = sum(A(:,1) == 'HC');
Donald = sum(A(:,1) == 'DT');
Bernie = sum(A(:,1) == 'BS');
JK = sum(A(:,1) == 'JK');
Ted = sum(A(:,1) == 'TC');
results_array = [Hillary, Donald, Bernie, JK, Ted];
names_array = {'HC','DT','BS','JK','TC'};
answer = [names_array; num2cell(results_array)];
Max = max(results_array);
disp(answer);
for j=1:n
    if results_array(j)==Max
        Winner = names_array(j);
    end
end
celldisp(Winner);

       