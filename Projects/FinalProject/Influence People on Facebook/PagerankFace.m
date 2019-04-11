clc;
clear;
close all;
edgesG = dlmread('facebookgraph.txt', ' ');
edgesG = 1 + edgesG; %to overcome 0 index
n = length(edgesG);
%Create Undireted Graph
UndirectedGraph = graph(edgesG(:,1), edgesG(:,2), ones(n,1));
K =34;
Linked = edgesG(:,1);
Link = edgesG(:,2);
X = PageRank(Linked, Link, n); %Run Pagerank
[Value, List] = sort(X,'descend');
Set_Nodes_Influence = 0;
S_k = List(1:K);
Last_Influence = [];
for i=1:K
    New_Set_Nodes = S_k(1:i);
    Find_Neighbors = [neighbors(UndirectedGraph, New_Set_Nodes(end)); New_Set_Nodes(end)];
    %Store added influence in S
    Added_Influence = setdiff(Find_Neighbors,Last_Influence);
    %Create new Influence
    Last_Influence = vertcat(Last_Influence,Added_Influence);   
    %Influence_list = New_Influence(S_k(1:i), UndirectedGraph, Influence_list);
    Set_Nodes_Influence(i) = length(Last_Influence);
    Opt_Node(i) = S_k(i,1);
end
sort(Opt_Node)
Total = array2table(Opt_Node,'RowNames',{'Optimal_Node_Set'})
display('The total optimal Influence I(S) = |N(S)|');
Total_Optimal_Influence = Set_Nodes_Influence(end);
disp(Total_Optimal_Influence);
plot(1:K, Set_Nodes_Influence(1:K),'-o');
xlabel('K');
ylabel('I(S)');

function [ x ] = PageRank( i, j, n, p )
%PAGERANK Calculates the PageRank of the given network.
%   param i: Vector of all nodes which are linked to.
%   param j: Vector of all nodes which link to other nodes.
%   param n: Number of nodes
%   param p: Decay rate (optional)
%   Note: Node i[k] links to node j[k].
%   Reference: https://www.mathworks.com/moler/exm/chapters/pagerank.pdf
if (~exist('p', 'var'))
    p = 0.85;
end
G = sparse(i, j, 1, n, n);
c = sum(G, 1);
k = find(c~=0);
D = sparse(k,k,1./c(k),n,n);
e = ones(n, 1);
I = speye(n, n);
x = (I - p*G*D)\e;
x = x/sum(x);
end

