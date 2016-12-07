function [ clusteringCoeff ] = GetClusteringCoef( A )
% Calculate clustering coefficient
% A = adjacency matrix in sparse mode

B = A*A*A;

%divided by three*2 because from each node with a triangle you can go two 
%directions and this happens at each node of the triangle
nbrTriangles = trace(B)/6;       

%nbr Triples
k = full(sum(A,2));
k = k.*(k-1)/2;
nbrTriples = sum(k);

clusteringCoeff = nbrTriangles*3/nbrTriples;

end

