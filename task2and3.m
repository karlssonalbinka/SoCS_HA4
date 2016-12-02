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

%%  task 3
clc
clear all

nFinal = 100;       %nbr of nodes in the end
nInitial = 7;       %nbr of nodes in beginning
p = 0.5;            %randoming out initial condition
m = 4;              %nbr of new modes every time step
nbrTimesteps = floor(nFinal-nInitial);
degree = zeros(1, nFinal);

% create circle coordinates
angleStep = 2*pi/nFinal;
k = 1:nFinal;
XY = [cos(angleStep*k); sin(angleStep*k)];

% initialize configuration
A = sparse(nFinal,nFinal);
x = 1:nInitial;
y = 1:nInitial;
for i = 1:nInitial
    randCoord = (rand(1,nInitial) < p);
    coordX = x(randCoord);
    coordY = y(randCoord);
    A(coordX', coordY') = 1;
end

figure(1)
gplot(A, XY(:, 1:nInitial)', '*-')

% newEdges_x = zeros(1, m*nbrTimesteps);
% newEdges_y = zeros(1, m*nbrTimesteps);
allNewNodes = zeros(2, m*nbrTimesteps);
for i_timestep = 1:nbrTimesteps
    i_timestep

    degree = full(sum(A,2));      %calculate degree
    totalDegree = sum(degree);
    degree = degree/totalDegree;

    %create added degrees for randoming out later on.
    cumulatedDegree = zeros(1,nInitial+(i_timestep-1)*m);
    for i = 1:nInitial+i_timestep;
        cumulatedDegree(i) = sum(degree(1:i));
    end

    %random what nodes to connect the new node to
    i_base = (i_timestep-1)*m;
    randNbr = rand(1,m);
    newNodes = zeros(1,m);
    newNode = 0;
    for i = 1:m
        while find(newNode == newNodes,1)
            newNode = find(cumulatedDegree > rand(1,1), 1);
        end
        newNodes(i) = newNode;
    end

    A(i_timestep + nInitial, newNodes) = 1;
end


figure(2)
gplot(A, XY', '*-')



