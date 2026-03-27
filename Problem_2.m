function [] = problem_2(f, a, b, n)
    tic;

    h = (b - a) / (2*n); % Step Size

    % Choosing Uniformly Spaces 2*n+1 points in the interval [a,b]
    x = linspace(a, b, 2*n+1);

    % Calculate functional values at these points
    fi = f(x);

    ai = zeros(1, n);
    for i = 1 : n 
        ai(i) = fi(2*i-1);
    end
    % Initializing array for bi's
    bi = zeros(1, n);

    % Calculating bi's
    for i = 1 : n 
        bi(i) = (fi(2*i) - fi(2*i-1)) / h;
    end

    ci = zeros(1, n);

    % Calculating ci's
    for i = 1 : n 
        ci(i) = (fi(2*i+1) - 2*fi(2*i) + fi(2*i-1)) / (2*h^2);
    end
    toc;

    % Plotting
    figure;
    hold on;

    % Choosing Dense points (say 10000)
    test_points = linspace(a, b, 10000);
    functional_value = f(test_points);

    % Approx values
    approx_value = zeros(size(test_points));

    for j = 1:length(test_points)
        
        % Finding the subinterval
        i = floor((test_points(j) - a)/(2*h)) + 1;
        if i > n
            i = n;
        end
        x0 = x(2*i - 1);
        x1 = x(2*i);
        % Quadratic interpolation
        approx_value(j) = ai(i) ...
            + bi(i)*(test_points(j) - x0) ...
            + ci(i)*(test_points(j) - x0)*(test_points(j) - x1);
    end

    % Plot comparison
    plot(test_points, functional_value, 'b', 'LineWidth', 2);
    plot(test_points, approx_value, 'r--', 'LineWidth', 2);

    legend('Actual f(x)', 'Piecewise Quadratic Approx');
    title('Piecewise Quadratic Interpolation');
    xlabel('x'); ylabel('y');
    grid on;

    % Error
    max_error = max(abs(functional_value - approx_value));
    disp(['Maximum Error = ', num2str(max_error)]);

    % Error plot (pointwise error)
    error_values = abs(functional_value - approx_value);

    figure;
    plot(test_points, error_values, 'k', 'LineWidth', 2);

    title('Pointwise Error |f(x) - s(x)|');
    xlabel('x'); ylabel('Error');
    grid on;
end