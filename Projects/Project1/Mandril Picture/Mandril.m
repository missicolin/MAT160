clc;
close all;
clear all;
load('mandril.mat', 'X','map');
image(X); colormap(map);
[U, S, V] = svd(double(X));
stem(diag(S)); grid;

subplot(2,2,1);
Aproximation(1,S,U,V);
title('SVD for k = 1');
subplot(2,2,2);
Aproximation(6,S,U,V);
title('SVD for k = 6');
subplot(2,2,3);
Aproximation(11,S,U,V);
title('SVD for k = 11');
subplot(2,2,4);
Aproximation(31,S,U,V);
title('SVD for k = 31');

%subplot(2,2,1);
%residuals(1,S,U,V,X);
%title('Residuals for k = 1');
%subplot(2,2,2);
%residuals(6,S,U,V,X);
%title('Residuals for k = 6');
%subplot(2,2,3);
%residuals(11,S,U,V,X);
%title('Residuals for k = 11');
%subplot(2,2,4);
%residuals(31,S,U,V,X);
%title('Residuals for k = 31');

h=gcf;
set(h,'PaperPositionMode','auto');         
set(h,'PaperOrientation','landscape');
set(h,'Position',[10 10 1200 850]);
print(gcf, '-dpdf', 'Mandril.pdf');

[k1 R] =fnorm(1,S,U,V,X);
[k6 R] = fnorm(6,S,U,V,X);
[k11 R] = fnorm(11,S,U,V,X);
[k31 R] = fnorm(31,S,U,V,X);

function X_k = Aproximation(k,S,U,V)
for j = 1:k
C=S;
C(j+1:end,:)=0;  
C(:,j+1:end)=0;
X_k = U*C*V';
end
X_k=uint8(X_k);
imagesc(X_k), colormap(gray);
end

function E = residuals(k,S,U,V,X)
for j = 1:k
C=S;
C(j+1:end,:)=0;  
C(:,j+1:end)=0;
X_k = U*C*V';
end
E = X -(X_k)
stem(diag(E)); grid;
end

function [N  RE]= fnorm(k,S,U,V,X)
for j = 1:k
D = diag(S);
C=S;
C(j+1:end,:)=0;  
C(:,j+1:end)=0;
X_k = U*C*V';
end
N = norm(X-(X_k),2);
RE = abs((S(k+1) - N)/S(k+1));
end

    