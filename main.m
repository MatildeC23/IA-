% Parameters for Simulated Annealing
T = 1000;             % Initial temperature
alpha = 0.99;         % Cooling rate
nRep = 50;            % Repetitions at each temperature
step_size = 0.02;     % Step size for neighbor generation
max_iterations = 300; % Maximum iterations
restarts = 1;        % Number of restarts

% Hill Climbing with restarts
[hc_best_value, hc_best_x] = hill_climbing_with_restarts(max_iterations, step_size, restarts);
fprintf('Hill Climbing: Max = %.4f, x = %.4f\n', hc_best_value, hc_best_x);

% Simulated Annealing
[sa_best_value, sa_best_x] = simulated_annealing(max_iterations, T, nRep, alpha, step_size);
fprintf('Simulated Annealing: Max = %.4f, x = %.4f\n', sa_best_value, sa_best_x);

% Plot results
plot_resultados(hc_best_value, hc_best_x, sa_best_value, sa_best_x);
