%task2
clc
clear all

n = 20;     % number of nodes
c = 2;      %nbr of closest neighbours connected to
p = 0.3;    %prob of connecting shortcut.

nbrEdges = n*c;

%create connection matrix
x = zeros(1, nbrEdges);
y = zeros(1, nbrEdges);
z = ones(1, nbrEdges);
for i = 1:n
    x(i*c-1:i*c) = 1+i:i+ c;
    y(i*c-1:i*c) = i;
end
x = mod(x-1,n) + 1;
A = sparse(x', y', z');

% create circle coordinates
angleStep = 2*pi/n;
k = 1:n;
XY = [cos(angleStep*k); sin(angleStep*k)];

figure(1)
gplot(A, XY')

%make shortcuts
%for each edge maybe place a new edge at random nodes
randNbr = rand(1,nbrEdges);
nbrNewEdges = sum(randNbr < p);
newEdgesXY = zeros(2,nbrNewEdges);
for i = 1:nbrNewEdges;
    newEdgesXY(:,i) = ceil(rand(1,2)*n);
end
A(newEdgesXY(1,:), newEdgesXY(2,:)) = 1;

figure(2)
gplot(A, XY')