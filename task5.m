% task5
clear all
clc
A = load('../smallWorldExample.mat');
A = A.A;
N = length(A);

% Plot graph
angleStep = 2*pi/N;
k = 1:N;
XY = [cos(angleStep*k); sin(angleStep*k)];
figure(1)
gplot(A, XY', '*-')

[path allPath] = GetMaxShortestPath(A, 100);
avgDiameter = sum(path)/N
avgPath = sum(sum(allPath),2)/(N*N)   %NOT RIGHT - MAYBE AVG PATH MEANS AVG OF PATH FROM EACH NODE TO EACH NODE AND NOT JUST AVG DIAMETER?

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
%Calculate average diameter
% One way of calculating the minimum distance is to incrementally multiply
% A with it self until all nodes has been covered. For example with matrix
% B (the test setup) if you add all elements on row one (distances from one
% to another node) you have to add B + B*B + B*B*B before no zeros remain
% -> max minimum path = 3.
%While for row two it's enough with adding B + B*B to cover all columns
%with non zero elements -> max min path = 2. This wors with the picture

[path, path2] = GetMaxShortestPath(B, 100)