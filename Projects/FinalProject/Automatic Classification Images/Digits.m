clc;
close all;
clear all;
load('azip.mat'); %Training Set
load('dzip.mat');  %Training Digit 
load('testzip.mat'); %Testing set
load('dtest.mat');   %Testing Digit
rowNames ={'Digit0','Digit1','Digit2','Digit3','Digit4','Digit5','Digit6','Digit7','Digit8','Digit9'};
[rowdtest, coldtest] = size(dtest);
[rowazip, colazip] = size(azip);
DigitAccuracy = [];%Allocate accuracy matrix
CorrectlyClassDig = [];%Allocate accuracy for each class 
counter=1;
k=[5,10,20];
%k = 1:50;
for i=1:size(k')
    m = i;
    leftSingularVector = zeros(rowazip,m,10);
    for L=0:9 %find left singular Vector for 0,..,9 digits.
        [U,S,V] = svds(azip(:,dzip==L),m);
        leftSingularVector(:,:,L+1) = U;
    end
    %for V=0:10
    %    for S=1:3
    %         saveas(ima2(leftSingularVector(:,S,V)),['digit-',num2str(V),'-',num2str(S),'.png']);
    %    end
    %end
    DigitLabel = -1*ones(size(dtest));
    for j = 1:coldtest
        DigitLabel(j) = findDigit(leftSingularVector,testzip(:,j));
    end
    %Compare found digit with dtest    
    for J=0:9        
        lab = dtest == J;        
        DigitAccuracy(counter, J+1)= sum(DigitLabel(lab)~=J)/sum(lab);%Find Wrong Digit
        DigitAccuracy(counter, J+1)= (1 - DigitAccuracy(counter, J+1))*100; %Calculate percentage
    end
    totalError = 100*sum((DigitLabel - dtest) ~= 0)/coldtest;    
    TotalAccuracy(counter)= 100-totalError;  
    counter = counter+1;
end
[percentage,location] = max(DigitAccuracy);
for i = 1:size(location')
    for j = 1:size(k')
    if location(i) == j
        location(i) = k(j);
    end
    end
end
figure 
plot(DigitAccuracy);
ylabel('Correct Classified Digits (%)');
xlabel('Basis vector');
%xticks([1 2 3]);
%xticklabels({'5','10','20'});
legend('Digit0','Digit1','Digit2','Digit3','Digit4','Digit5','Digit6','Digit7','Digit8','Digit9');
Result = [percentage; location];
T = array2table(Result','RowNames',rowNames,'VariableNames', {'Accuracy','BasisVector'});
display(T);
function digit = findDigit(foundApproximation, actualData)
    %Find digit with minimum error comparing testing set and left singular
    %vector
    uperbound = realmax;
     alloDigit = -1;
    for i =0:9 %Compute 2-norm Residual Error ||y - K*(K'*y||2 
        E = norm(actualData - foundApproximation(:,:,i+1)*(foundApproximation(:,:,i+1)'*actualData),2);
        if uperbound > E
            uperbound = E;
            alloDigit = i;
        end
    end
    digit = alloDigit;
end