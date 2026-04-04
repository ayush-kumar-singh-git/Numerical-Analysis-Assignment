function [] = Problem_2(f, a, b, n)
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
        % Quadratic interpolation
        x1 = x(2*i);
        approx_value(j) = ai(i) ...
            + bi(i)*(test_points(j) - x0) ...
            + ci(i)*(test_points(j) - x0)*(test_points(j) - x1);
    end

    % Plot comparison
    plot(test_points, functional_value, 'b', 'LineWidth', 2);
    plot(test_points, approx_value, 'r--', 'LineWidth', 2);
    xlim([pi/2 pi/2+0.01]);
    ylim auto
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

    % Plotting Relative error 
    rel_error = (error_values ./ max(abs(functional_value), 1e-12))*100;

    figure;
    plot(test_points, rel_error, 'r', 'LineWidth', 2);

    title('Relative Error |f(x) - s(x)| / |f(x)|');
    xlabel('x'); ylabel('Relative Error');
    grid on;

% % ===== CSV EXPORT =====

% % Choose points
% table_x = linspace(0, 2*pi, 11);

% actual_vals = f(table_x);
% approx_vals = zeros(size(table_x));

% for j = 1:length(table_x)
%     i = floor((table_x(j) - a)/(2*h)) + 1;
%     if i > n
%         i = n;
%     elseif i < 1
%         i = 1;
%     end

%     x0 = x(2*i - 1);
%     x1 = x(2*i);

%     approx_vals(j) = ai(i) ...
%         + bi(i)*(table_x(j) - x0) ...
%         + ci(i)*(table_x(j) - x0)*(table_x(j) - x1);
% end

% % Errors
% abs_error = abs(actual_vals - approx_vals);
% rel_error = (abs_error ./ max(abs(actual_vals), 1e-12)) * 100;

% % Combine into matrix
% data = [table_x(:), actual_vals(:), approx_vals(:), abs_error(:), rel_error(:)];

% % Write CSV file
% filename = 'interpolation_results.csv';

% % Header
% fid = fopen(filename, 'w');
% fprintf(fid, 'x,Actual,Approx,AbsError,RelErrorPercent\n');
% fclose(fid);

% % Append data
% dlmwrite(filename, data, '-append');

% disp(['CSV file saved as: ', filename]);
end