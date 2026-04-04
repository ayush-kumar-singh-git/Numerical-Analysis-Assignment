% Main Script For the Adaptive Approximation and Plotting
clc; clear; close all;
format long;
f = @(x) sqrt(x);
tol = 1e-5;
a = 0;
b = 1;
%% Adaptive method
tic;
X = partition(a, b, tol);
toc

disp(["Number of Partitions: " num2str(length(X)-1)])

xq = linspace(a,b,1000);

% Plotting
figure;
hold on;

% Choose Dense points for plotting
test_points = linspace(a, b, 10000);
functional_value = f(test_points);

% Use the generated partition
approx_value = approximate(X, f, test_points);

% Plot comparison
plot(test_points, functional_value, 'b', 'LineWidth', 2);
plot(test_points, approx_value, 'r--', 'LineWidth', 2);

legend('Actual f(x)', 'Piecewise Linear Approx');
title('Adaptive Piecewise Linear Interpolation');
xlabel('x'); ylabel('y');
grid on;

% Error
error_values = abs(functional_value - approx_value);
max_error = max(error_values);

disp(['Maximum Error = ', num2str(max_error)]);

% Error plot
figure;
plot(test_points, error_values, 'k', 'LineWidth', 2);

title('Pointwise Error |f(x) - s(x)|');
xlabel('x'); ylabel('Error');
grid on;

% Relative error
rel_error = (error_values ./ max(abs(functional_value), 1e-12))*100;

figure;
plot(test_points, rel_error, 'r', 'LineWidth', 2);

title('Relative Error |f(x) - s(x)| / |f(x)|');
xlabel('x'); ylabel('Relative Error (%)');
grid on;