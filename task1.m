% Home assignment 4 - Simulation of complex systems
% recommended commands: gplot and sparse
clear all
clc

%task 1 - Erdos-Reniy model
N = 200;         %nbr of nodes
p = 0.3;        %probability of connecting nodes
k = 1:N;
A = sparse(N,N); %ajacancy matrix
randConnections = rand(1,N*N);
A(randConnections < p) = 1;
%empty bottom half of adjacancy matrix to get right number of edges
for i = 1:N
    A(i,1:i) = 0;
end
A = A+A';       % make symmetric (undirected graph)
full(sum(sum(A),2))/2   %divided by two because there are two contributions from each edge (symmetric)
p*N*(N-1)/2


%Create circular points
angleStep = 2*pi/N;
coordinates = [cos(angleStep*k); sin(angleStep*k)];

gplot(A, coordinates')

%Distribution
distr = full(sum(A,2));
%theoretical distribution
kMin = 20;
kMax = 100;
k = kMin:kMax;
P = zeros(1,kMax-kMin+1);
% P = factorial(N-1)./factorial(k)*p.^k*(1-p).^(N-1-k);
for k =kMin:kMax
    top = prod(N-1-k:N-1);
    bottom = prod(1:N-1-k);
    P(k-kMin+1) = top/bottom*p^k * (1-p)^(N-1-k);
end

hold off
figure(2)
hist(distr)
hold on
plot([kMin:kMax], P, 'r')
axis([kMin kMax 0 80])
% histogram(distr)