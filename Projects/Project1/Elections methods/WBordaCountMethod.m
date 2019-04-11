[x1, x2, x3, x4, x5,] = importdata('rankingcandidates.dat', 1, 240);
A = [x1 x2 x3 x4 x5];
B = fliplr(A);
names_array = {'HC','DT','BS','JK','TC'};
W = [11 7 6 6 4] %[9 7 5 3 1] [8 6 4 2 1]  
%[5 4 3 2 1] [9 4 4 2 1] [6 6 5 4 2] 
W_n = fliplr(W);
[m n] = size(A);
Hillarysum = 0;
Donaldsum = 0;
Berniesum = 0;
JKsum = 0;
Tedsum = 0;
for i = 1:n
    Hillary = (W_n(i))*sum(B(:,i) == 'HC');
    Hillarysum = (Hillarysum + Hillary);
    Donald = (W_n(i))*sum(B(:,i) == 'DT');
    Donaldsum = (Donaldsum + Donald);
    Bernie = (W_n(i))*sum(B(:,i) == 'BS');
    Berniesum = (Berniesum + Bernie);
    JK = (W_n(i))*sum(B(:,i) == 'JK');
    JKsum = (JKsum + JK);
    Ted = (W_n(i))*sum(B(:,i) == 'TC');
    Tedsum = (Tedsum + Ted);
       
end
results_array = [Hillarysum, Donaldsum, Berniesum, JKsum, Tedsum];
answer = [names_array; num2cell(results_array)];
Max = max(results_array);
disp(answer);
for j=1:n
    if results_array(j)==Max
        Winner = names_array(j);
    end
end
celldisp(Winner);