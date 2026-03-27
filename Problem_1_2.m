format long;
clc; clear all;

tic;
%% Test Function
%% Since we need to evaluate function at various points
%% we use vectorization (element wise operations)
f = @(x) sqrt(x);

%% Defining the Interval
a = 0;
b = 1;

%% Number of Subintervals
n = 24998;
h = (b - a) / n; %% Step Size

%% Choosing Uniformly Spaces n+1 points in the interval [a,b]
x = linspace(a, b, n+1);

%% Calculate functional values at these points = ai's
ai = f(x);

%% Initializing array for bi's
bi = zeros(1, n);

%% Calculating bi's
for i = 1 : n 
    bi(i) = (ai(i+1) - ai(i)) / h;
end

toc;

%% Plotting
figure;
hold on;

%% Choosing Dense points (say 10000)
test_points = linspace(a, b, 10000);
functional_value = f(test_points);

%% Approx values
approx_value = zeros(size(test_points));

for j = 1:length(test_points)
    
    % Finding the subinterval
    i = floor((test_points(j) - a)/h) + 1;
    if i > n
        i = n;
    end
    
    % Piecewise linear formula
    approx_value(j) = ai(i) + bi(i)*(test_points(j) - x(i));
end

%% Plot comparison
plot(test_points, functional_value, 'b', 'LineWidth', 2);
plot(test_points, approx_value, 'r--', 'LineWidth', 2);

legend('Actual f(x)', 'Piecewise Linear Approx');
title('Piecewise Linear Interpolation');
xlabel('x'); ylabel('y');
grid on;

%% Error
max_error = max(abs(functional_value - approx_value));
disp(['Maximum Error = ', num2str(max_error)]);

%% Error plot (pointwise error)
error_values = abs(functional_value - approx_value);

figure;
plot(test_points, error_values, 'k', 'LineWidth', 2);

title('Pointwise Error |f(x) - s(x)|');
xlabel('x'); ylabel('Error');
grid on;