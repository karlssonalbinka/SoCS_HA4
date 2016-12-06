function [ path ] = GetMaxShortestPath( A )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
N = length(A);

path = zeros(N, 1);     %to store the shortest path for each node
toCheck = true(1,N);    %to not check each node every time
C = 1;                  %to take product with it self
D = zeros(N,N);                  %to add and see how many paths one might take to get to each node
id = 1:N;

i = 0;
while find(path == 0, 1)
    temp_id = id(toCheck);
    i = i + 1;
    C = C*A;
    D = D + C;
    index = temp_id(sum(D(toCheck,:) == 0, 2) == 0);
    path(index) = i;
    toCheck(index) = 0;
end
return

end

