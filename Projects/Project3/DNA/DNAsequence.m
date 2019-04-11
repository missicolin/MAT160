
function [TotalCost, Alignment_S, Alignment_T] = DNAsequence(seq, ~)
tic;
[A, B] = textread(seq,'%s %s','delimiter','\n','bufsize',50000);
S = cell2mat(A) %sequence s
T = cell2mat(B) %sequence t

%gap penalty = -2
g = -2;
%match = 1, mismatch = -1
m = 1;
s = -1;

%gap | mismatch to compute total cost c := 2 * gap + m  
gap = 2; 
mistmatch = 1;

col = length(S);
row = length(T);
% rows|columns

%preallocating matrix F with the gap penalty as the top row and column
F = zeros(row+1,col+1);
F(2:end,1) = g * (1:row)';
F(1,2:end) = g * (1:col);

%variables
if (nargin == 3)
    matchS = 1;
    matchT = 1; 
    %sets first match position
    counterS = matches(matchS);
    counterT = matches(matchT,3);
end

TotalCost = 0;
scores = zeros(row, col);
%Filling in the matrix
for i=2:row+1
    for j=2:col+1        
        %wrapper function for input matches file
        if (nargin == 3)
           if (j == counterS && i == counterT)
               %assigns the position as a match
               F(i,j) = F(i-1,j-1) + scores(S(j-1),T(i-1));
               stop = matches(matchS,2);
               final = size(matches,1);
               %checks if end of the known match
               if (counterS == stop)
                   %checks if  end of the text file
                   if (matchS == final)
                       continue
                   else
                       matchS = matchS + 1;
                   end
               else
                   %counts known matched sequence
                   counterS = counterS + 1;
                   counterT = counterT + 1;
               end
               %skips to the next iteration
               continue
            end
        end
        %if the two positions match
        if (S(j-1) == T(i-1))
            scores(S(j-1),T(i-1)) = m;
        else
            scores(S(j-1),T(i-1)) = s;
        end       
        %Filling-in partial alignments here  
        Match     = F(i-1,j-1) + scores(S(j-1),T(i-1));
        MismatchS = F(i, j-1) + g;
        MismatchT = F(i-1, j) + g;
        %choose final score of the alignment and assigning it to F
        Temp = [Match MismatchS MismatchT];
        F(i,j) = max(Temp);
    end
end

Alignment_S = '';
Alignment_T = '';
i = length(T)+1; %row
j = length(S)+1; %col

while (i>1 && j>1)
   Score = F(i,j);
   DIAG = F(i-1,j-1);
   LEFT = F(i-1,j);
   UP   = F(i,j-1);
   
   %if scores are equal to the diagonal, No gap.
   if (Score == DIAG + scores(S(j-1),T(i-1)))
       Alignment_S = strcat(Alignment_S, S(j-1));
       Alignment_T = strcat(Alignment_T, T(i-1));
       %computes score, checks to see if the alignment are the same
       %characters
       if (S(j-1) ~= T(i-1))
           %mismatch
           TotalCost = TotalCost + mistmatch;
       end
       i = i-1;
       j = j-1;
   
   %gap in sequence T
   elseif (Score == UP + g)
       Alignment_S = strcat(Alignment_S, S(j-1));
       Alignment_T = strcat(Alignment_T, '-');
       j = j-1;
       %computes score by adding the gap penalty
       TotalCost = TotalCost + gap;
   %gap in sequence S
   else
       Alignment_S = strcat(Alignment_S, '-');
       Alignment_T = strcat(Alignment_T, T(i-1));
       i = i-1;
       TotalCost = TotalCost + gap;
   end
end
%Fill end of a sequence with gaps
while(j>1)
   Alignment_S = strcat(Alignment_S, S(j-1));
   Alignment_T = strcat(Alignment_T, '-');
   j = j-1;
   %2 for gaps
   TotalCost = TotalCost + gap;
end
while(i>1)
   Alignment_S = strcat(Alignment_S, '-');
   Alignment_T = strcat(Alignment_T, T(i-1));
   i = i-1;
   TotalCost = TotalCost + gap;
end
Alignment_S = fliplr(Alignment_S);
Alignment_T = fliplr(Alignment_T);
%displays the alignment score and alignments
disp('Total Aligment Cost =');
disp(TotalCost);
disp('Aligment S =');
disp(Alignment_S);
disp('Aligment T =');
disp(Alignment_T);
toc;