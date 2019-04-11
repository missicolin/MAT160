clc;
close all;
clear all;
[x1 x2 x3 x4 x5] = importdata('rankingcandidates.dat', 1, 240);
A = [x1 x2 x3 x4 x5];
B = fliplr(A);
[m n] = size(A);
Hillarysum = 0;
Donaldsum = 0;
Berniesum = 0;
JKsum = 0;
Tedsum = 0; 
for i = 1:n
    Hillary = (i-1)*sum(B(:,i) == 'HC');
    Hillarysum = (Hillarysum + Hillary);
    Donald = (i-1)*sum(B(:,i) == 'DT');
    Donaldsum = (Donaldsum + Donald);
    Bernie = (i-1)*sum(B(:,i) == 'BS');
    Berniesum = (Berniesum + Bernie);
    JK = (i-1)*sum(B(:,i) == 'JK');
    JKsum = (JKsum + JK);
    Ted = (i-1)*sum(B(:,i) == 'TC');
    Tedsum = (Tedsum + Ted);
    %Flip matrix A so that if we multiply i candidate
    %gets (i-1) points. 
end
results_array = [Hillarysum, Donaldsum, Berniesum, JKsum, Tedsum];
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



