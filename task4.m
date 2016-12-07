%task 4.
clear all
clc

A = load('../smallWorldExample');
A = A.A;
N = length(A);

% PlotGraph
% create circle coordinates
angleStep = 2*pi/N;
k = 1:N;
XY = [cos(angleStep*k); sin(angleStep*k)];
figure(1)
gplot(A, XY', '*-')
title('clustering coeff = 0.611279563371740')



coeff = GetClusteringCoef(A)



%% Testing
clc
XY = [1 1 2 3 3; 0 2 1 0 2]; 
B = [0 1 0 0 0;...  %node 1 - lower left corner
    1 0 1 0 0; ...  %node 2 - upper left corner
    0 1 0 1 1;...   %node 3 - center node
    0 0 1 0 1;...   %node 4 - upper right corner
    0 0 1 1 0];     %node 5 - lower right corner
gplot(B, XY', '-*')
axis([0 4 -1 3])

% coeff = GetClusteringCoef(A)
%nbr Triangles
B
C = B*B*B
% nbrTriangles = full(sum( sum(C==3, 2) ));
% nbrTriangles = nbrTriangles/2
nbrTriangles = trace(C)/6


%nbr Triples
k = full(sum(B,2))
k = k.*(k-1)/2
nbrTriples = sum(k)