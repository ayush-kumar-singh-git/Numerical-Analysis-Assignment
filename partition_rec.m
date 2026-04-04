% Performs the recursive interval splitting
function X = partition_rec(a, b, tol)
    % Evaluating the function at both end points and middle point
    fa = sqrt(a); 
    fb = sqrt(b);
    
    m = (a + b)/2;
    fm = sqrt(m);
    
    % Finding the linear approximation at middle point
    Lm = fa + (fb - fa)*(m - a)/(b - a);
    
    % Estiamting quality of the partition
    % if a is large enough we use the theoretical maximum
    % if a too close to zero we take the error at mid point as a measaure of quality of approximation
    if a < 1e-12
        err = abs(fm - Lm);
    else
        err = (b - a)^2 / (32 * a^(3/2));
    end
    
    % if required tolerance is achieved we return the partition
    if err <= tol
        X = b;
    % if not then we recursively call the function for the left half and right half sub intervals
    else
        X_left = partition_rec(a, m, tol);
        X_right = partition_rec(m, b, tol);
        X = [X_left, X_right];
    end
end