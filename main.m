% Parameters for Simulated Annealing
T = 100;              % Initial temperature
alpha = 0.99;         % Cooling rate
nRep = 50;            % Repetitions at each temperature
step_size = 0.02;     % Step size for neighbor generation
max_iterations = 300; % Maximum iterations
restarts = 10;         % Number of restarts

%------------------------------------------
% Hill Climbing with restarts
[hc_best_value, hc_best_x] = hill_climbing(max_iterations, step_size, restarts);
fprintf('Hill Climbing: Max = %.4f, x = %.4f\n', hc_best_value, hc_best_x);
%---------------------------------------------
% Rodar o algoritmo
[best_value, best_x] = simulated_annealing(max_iterations, T, nRep, alpha, step_size);
% Exibir os resultados
fprintf('Melhor valor encontrado no simulated annealing: f(x) = %.4f em x = %.4f\n', best_value, best_x);
%-------------------------------------------------
% Executa o algoritmo
[best_value, best_x] = multiple_restart_hill_climbing(max_iterations, step_size, restarts);
% Exibe o melhor resultado global encontrado
fprintf('Multiple Restart Hill Climbing: Max = %.4f, x = %.4f\n', best_value, best_x);
