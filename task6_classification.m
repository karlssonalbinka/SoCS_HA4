%task 6
clear all
clc
network1 = load('../network1');
network2 = load('../network2');
network3 = load('../network3');
network1 = network1.s;
network2 = network2.s;
network3 = network3.s;
%create sparse matrix
N1 = length(network1);
N2 = length(network2);
N3 = length(network3);
z = ones(1,N1);
network1 = sparse(network1(:,1), network1(:,2), z);
z = ones(1,N2);
network2 = sparse(network2(:,1), network2(:,2), z);
z = ones(1,N3);
network3 = sparse(network3(:,1), network3(:,2), z);

tic
clustering_1 = GetClusteringCoef(network1);                     %Clustering
clustering_2 = GetClusteringCoef(network2);
clustering_3 = GetClusteringCoef(network3);
calcClustering = toc
tic
tic
[longestPaths_1, allPaths_1] = GetMaxShortestPath(network1, 100);
toc
tic
[longestPaths_2, allPaths_2] = GetMaxShortestPath(network2, 100);
toc
tic
[longestPaths_3, allPaths_3] = GetMaxShortestPath(network3, 100);
toc
calcPaths = toc
diameter_1 = max(longestPaths_1);                               %Diameter
diameter_2 = max(longestPaths_2);
diameter_3 = max(longestPaths_3);
avgPathLength_1 = sum(longestPaths_1)/(N1*(N1-1));              %Avg path lengths
avgPathLength_2 = sum(longestPaths_2)/(N2*(N2-1));
avgPathLength_3 = sum(longestPaths_3)/(N3*(N3-1));

%%
clc
sprintf('Clustering:\t\t%f\t%f\t%f \nDiameter:\t\t%f\t%f\t%f \navg path length\t%f\t%f\t%f', clustering_1, clustering_2, clustering_3, diameter_1, diameter_2, diameter_3, avgPathLength_1, avgPathLength_2, avgPathLength_3)
% sprintf('Diameter:\t\t%f\t%f\t%f', diameter_1, diameter_2, diameter_3)
% sprintf('average path length\t%f\t%f\t%f', avgPathLength_1, avgPathLength_2, avgPathLength_3)