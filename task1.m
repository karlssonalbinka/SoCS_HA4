% Home assignment 4 - Simulation of complex systems
% recommended commands: gplot and sparse
clear all
clc

%task 1 - Erdos-Reniy model
N = 20;         %nbr of nodes
p = 0.3;        %probability of connecting nodes
k = 1:N;
diag = [k', k'];
A = sparse(N,N); %ajacancy matrix
randConnections = rand(1,N*N);
A(randConnections > p) = 1;
A(diag) = 0;

%Crate circular points
angleStep = 2*pi/N;
coordinates = [cos(angleStep*k); sin(angleStep*k)];

% plot(coordinates(1,:), coordinates(2,:), 'r*')

% [X, Y] = find(A == 1);
% XY = [Y, X];
% k = 1:N*N;
gplot(A, coordinates')

%%
clear all
clc
% k = 1:30;
[B,XY] = bucky;
gplot(B,XY,'-*')
axis square