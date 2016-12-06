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

nFinal = 5000;       %nbr of nodes in the end
nInitial = 20;       %nbr of nodes in beginning
p = 0.5;            %randoming out initial condition
m = 5;              %nbr of new modes every time step
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
    randCoord = (rand(1,i) < p);
    coordX(1:i) = x(i);
    coordY = y(randCoord);
    A(coordX', coordY') = 1;
end
A = A+A';   %make symmetric

figure(1)
gplot(A, XY(:, 1:nInitial)', '*-')
title('Initial configuration')
xlabel(['N_{initial} = ' num2str(nInitial)])

% newEdges_x = zeros(1, m*nbrTimesteps);
% newEdges_y = zeros(1, m*nbrTimesteps);
allNewNodes = zeros(2, m*nbrTimesteps);
tic
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
    A(newNodes, i_timestep + nInitial) = 1;
end

figure(2)
gplot(A, XY', '*-')
title('Final configuration')
xlabel(['N_{final} = ' num2str(nFinal) ', m = ' num2str(m)])
% a=full(sum(A,2))
%%
%Create and plot power law
clc
distr = full(sum(A,2));

%create histogram distribution
for i = 1:nFinal
    x(i) = sum(distr == i);
end
x2 = x/max(x);
x = sort(x)/max(x);

k = [nFinal:-1:1]./nFinal;
figure(1)
loglog(x,k)
hold on

F = 2*m^2.*k.^(-2);
F2 = F/max(F);
F = sort(F./max(F));

loglog(F,k,'r')
title('power law')
xlabel(['N_{final} = ' num2str(nFinal) ', m = ' num2str(m)])
legend('simulation', 'theoretical');

figure(2)
plot(x2, 'b');
hold on
plot(F2(end:-1:1), 'r')
