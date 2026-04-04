% Evaluates the approximation at some query points (xq)
function yq = approximate(X, f, xq)
    % Evaluate piecewise linear interpolation
    
    Y = f(X); % function values at nodes
    n = length(X);
    
    yq = zeros(size(xq)); % Array to store approximations
    
    for k = 1:length(xq)
        x = xq(k);
        
        % Find interval in which x lies
        i = find(X <= x, 1, 'last');
        
        % Handle right boundary
        if i == n
            i = n - 1;
        end
        
        % Endpoints
        x1 = X(i); x2 = X(i+1);
        y1 = Y(i); y2 = Y(i+1);
        
        % Linear interpolation
        yq(k) = y1 + (y2 - y1)*(x - x1)/(x2 - x1);
    end
end