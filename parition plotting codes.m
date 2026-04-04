%% Adaptive Grid Visualization (Grouped by 10)

figure;
hold on;

n = length(X);
group_size = 10;
num_groups = ceil((n-1)/group_size);

colors = lines(num_groups);

% Interval lengths (for thickness scaling)
interval_lengths = diff(X);
scaled = interval_lengths / max(interval_lengths);

% Plot intervals
for i = 1:n-1
    group_id = ceil(i / group_size);
    
    plot([X(i), X(i+1)], [0, 0], ...
        'Color', colors(group_id,:), ...
        'LineWidth', 3 + 4*(1 - scaled(i)));
end

% Group boundaries (subtle vertical ticks)
for g = 1:num_groups
    idx = (g-1)*group_size + 1;
    if idx <= n
        xg = X(idx);
        plot([xg xg], [-0.03 0.03], 'k--', 'LineWidth', 0.8);
    end
end

% Axis styling
title(sprintf('Adaptive Partition (Grouped by 10 Intervals)\nTotal intervals = %d | tol = %g', n-1, tol));

xlabel('x');
ylim([-0.1, 0.1]);
yticks([]);
grid on;

set(gca, 'LineWidth', 1.2, 'FontSize', 10);
box on;