% Returns adaptive partition of [a,b]
function X = partition(a, b, tol)
    X = a; % start with left endpoint
    X = [X, partition_rec(a, b, tol)];
end