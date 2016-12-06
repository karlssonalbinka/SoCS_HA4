%task 4.
clear all
clc

A = load('../smallWorldExample');
A = A.A;
N = length(A);
% PlotGraph

% create circle coordinates
% angleStep = 2*pi/N;
% k = 1:N;
% XY = [cos(angleStep*k); sin(angleStep*k)];
% figure(1)
% gplot(A, XY', '*-')



% coeff = GetClusteringCoef(A)
%nbr Triangles
B = A*A*A;
nbrTriangles = full(sum( sum(B==3, 2) ));
nbrTriangles = nbrTriangles/6; %Is this right?!?!

%nbr Triples
k = full(sum(A,2));
k = k.*(k-1)/2;
nbrTriples = sum(k);

clusteringCoeff = nbrTriangles*3/nbrTriples