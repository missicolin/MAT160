clc;
close all;
clear all;
Q = importexamscores('examscores.dat', 1, 31);
[row col] = size(Q);
r = rank(Q);
[U, S, V] = svds(Q,r)
D = diag(S);
E=inf;
while 1 %error SVD
    [U,S,V] = svds(Q,r);
    X=U*S*V';
    Nor=norm(Q-X,2)^2;
   if(Nor<E)
       E=Nor;
   else
       break;
   end
end
    
eigs = D.^2;%eigenvales square
var_seq =cumsum(eigs);
tot_var = sum(eigs);
exp_var = var_seq/tot_var;
Porc = 100*exp_var






