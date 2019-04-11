clc;
clear;
close all;
edgesG = dlmread('facebookgraph.txt', ' ');
edgesG = 1 + edgesG; %to overcome 0 index
n = length(edgesG);
%Create Undireted Graph
UndirectedGraph =  graph(edgesG(:,1), edgesG(:,2), ones(n,1));
K = 10;
S_K = zeros(K,1);
Set_Nodes_Influence = zeros(K,1);
Maximal_Influence = 0;
Last_Influence = [];
DisplayResult = [];
FoundSol = 0;
%Implementing Greedy Algorithm
%Run for every node which maximize influence |(G,S+{v})-(G,S)|
%Every use a new node and influence S. 

for i = 1:K
    New_Set_Nodes = S_K(1:i);
    Influence_ID = 0;
    for j = 1:UndirectedGraph.numnodes
        New_Set_Nodes(i) = j;
        %Add new node to end of S to modify influence finding conexion
        Find_Neighbors = [neighbors(UndirectedGraph, New_Set_Nodes(end)); New_Set_Nodes(end)];
        %Store added influence in S
        Added_Influence = setdiff(Find_Neighbors,Last_Influence);
        %Create new Influence
        NewInfluence = vertcat(Last_Influence,Added_Influence);
        %Verify if New Influence has been found
        if length(NewInfluence) > length(Maximal_Influence);
            Influence_ID = j;
            Maximal_Influence = NewInfluence;
        end
    end
    S_k(i) = Influence_ID;
    Set_Nodes_Influence(i) = length(Maximal_Influence);
    Last_Influence = Maximal_Influence; 
    DisplayResult(i) = length(Last_Influence);
    %Verify if the Optimal influence has been found in K steps. 
    if length(Last_Influence) + i >= UndirectedGraph.numnodes
        disp('Optimal found at K =');
        K_opt = i;
        disp(K_opt)
       break;
    end  
end
Total_Optimal_Influence = length(Last_Influence);
ValueK = [DisplayResult; S_k];
Total = array2table(ValueK,'RowNames',{'I(S)','Optimal_Node_Set'})
display('The total optimal Influence I(S) = |N(S)| is: ');
disp(Total_Optimal_Influence);

plot(1:K, Set_Nodes_Influence(1:K),'-o');
xlabel('K');
ylabel('I(S)');


        
        
        
        
    

   
    


