function [ path, path2 ] = GetMaxShortestPath( A, maxIteration )
%OUT - Path: shortest paths for each node
%   Detailed explanation goes here
N = length(A);

path = zeros(N, 1);     %to store the shortest path for each node
toCheck = true(1,N);    %to not check each node every time
C = 1;                  %to take product with it self
D = zeros(N,N);         %to add and see how many paths one might take to get to each node

i = 0;
id = 1:N;
accessUpperDiag = triu(true(N,N), 1);
while (~isempty(find(path == 0, 1)) && i<maxIteration)
    temp_id = id(toCheck);
    i = i + 1;
    C = C*A;
    D = D + C;
    index = temp_id(sum(D(toCheck,:) == 0, 2) == 0);
    path(index) = i;
    toCheck(index) = 0;
end

%to get all shortest paths from one node to the other
path2 = zeros(N,N);
id = 1:N;
i = 0;
C = 1;
D = zeros(N,N);         %to add and see how many paths one might take to get to each node
temp = zeros(N,N);
while ( ~isempty(find(path2(accessUpperDiag) == 0, 1)) && i < maxIteration)
    i = i + 1;
    C = C*A;
%     D = D + C;
    i_notTaken = path2 == 0;
    i_existingPaths = C > 0;
    i_toUpdate = i_notTaken.*i_existingPaths == 1;
%     temp(D == 1) = i;
    path2(i_toUpdate) = i;
end

diag = 1:N;
diag = sub2ind([N,N], diag,diag);
path2(diag) = 0;



return

end

