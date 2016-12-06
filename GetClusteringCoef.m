function [ clusteringCoeff ] = GetClusteringCoef( A )
% Calculate clustering coefficient
% A = adjacency matrix in sparse mode

B = A*A*A;
nbrTriangles = full(sum( sum(B==3, 2) ));
k = full(sum(A,2));
k = k.*(k-1)/2;
nbrTriples = sum(k);

clusteringCoeff = nbrTriangles*3/nbrTriples;

end

