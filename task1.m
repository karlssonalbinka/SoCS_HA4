% Home assignment 4 - Simulation of complex systems
% recommended commands: gplot and sparse
clear all
clc
tic
%task 1 - Erdos-Reniy model
N = 40;         %nbr of nodes
p = 0.3;        %probability of connecting nodes
% A = sparse(N,N); %ajacancy matrix
k = 1:N;
randConnections = rand(N,N);
randConnections = triu(randConnections);
randConnections = randConnections + randConnections'; %make symmetric
[x,y] = find(randConnections < p);
z = ones(1,length(x));
A = sparse(x,y,z);

a = toc
% full(sum(sum(A),2))/2   %divided by two because there are two contributions from each edge (symmetric)
% p*N*(N-1)/2


%Create circular points
angleStep = 2*pi/N;
coordinates = [cos(angleStep*k); sin(angleStep*k)];
gplot(A, coordinates')
title('Erd˜os-R´enyi random graph')
xlabel(['N = ' num2str(N) ', p = ' num2str(p)])

tic
%Distribution
distr = full(sum(A,2));
x = zeros(1, max(distr) );
for i = 1:max(distr)
    x(i) = sum(distr == i);
end
x = x/sum(x);
b = toc
%theoretical distribution
tic
kMin = 3000;
kMax = ceil(N/2);
k = kMin:kMax;
P = zeros(1,kMax-kMin+1);
n = N-1;
for k =kMin:kMax
    P(k-kMin+1) = binopdf(k, n, p);
end
c = toc
hold off
figure(2)
% histogram(distr, 'Normalization','probability')
plot(1:length(x), x)
hold on
plot([kMin:kMax], P, 'r')
title('degree distribution')
xlabel(['N = ' num2str(N) ', p = ' num2str(p)])
tot = a+b+c