function [best_global, best_global_x] = simulated_annealing(max_iterations, T_init, nRep, alfa, step_size)


    % Definir o intervalo e a função alvo
    x_range = linspace(0, 1.6, 1000);
    f = @(x) 4 * (sin(5 * pi * x + 0.5).^6) .* exp(log2((x - 0.8).^2)); % Exemplo da função
    f_values = arrayfun(f, x_range);

    % Determinar o máximo global para referência
    [global_max_value, idx] = max(f_values);
    global_max_x = x_range(idx);

    % Inicializar a temperatura
    T = T_init;

    % Selecionar um ponto inicial aleatório no intervalo [0, 1.6]
    x_current = rand * 1.6;
    f_current = f(x_current);

    % Inicializar o melhor global
    best_global_x = x_current;
    best_global = f_current;

    % Armazenar histórico para plotagem
    temperature_history = [];
    best_history = [];

    % Início do loop de Simulated Annealing
    for iter = 1:max_iterations
        for rep = 1:nRep
            % Gerar um vizinho aleatório
            x_neighbor = x_current + (rand * 2 - 1) * step_size;

            % Verificar se o vizinho está dentro do intervalo permitido
            if x_neighbor >= 0 && x_neighbor <= 1.6
                f_neighbor = f(x_neighbor);
                dE = f_neighbor - f_current; % Gradiente de energia

                % Verificar se aceita o vizinho
                if dE > 0 || rand < exp(dE / T) % Aceita melhora ou piora com probabilidade
                    x_current = x_neighbor;
                    f_current = f_neighbor;

                    % Atualizar o melhor global
                    if f_current > best_global
                        best_global_x = x_current;
                        best_global = f_current;
                    end
                end
            end

            % Atualizar histórico a cada repetição
            temperature_history = [temperature_history, T];
            best_history = [best_history, best_global];
        end

        % Atualizar a temperatura
        T = alfa * T;
    end

   
    %% Gráficos do SA
    figure;

    % Gráfico 1: Evolução da temperatura e do melhor valor global
    subplot(1, 2, 1);
    plot(1:length(temperature_history), temperature_history, 'b-', 'LineWidth', 1.5); hold on;
    plot(1:length(best_history), best_history, 'r-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('Valores');
    title('Evolução da Temperatura e do Melhor Valor');
    legend('Temperatura', 'Melhor Valor f(x)', 'Location', 'Best');
    grid on;
%---------------------------------------------------------------------------------------------------------------------------------------
    % Gráfico 2: Visualização da função e ponto encontrado
    subplot(1, 2, 2);
    plot(x_range, f_values, 'b-', 'LineWidth', 1.5); hold on;
    plot(global_max_x, global_max_value, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 2); % Máximo global
    plot(best_global_x, best_global, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'LineWidth', 2); % Melhor ponto encontrado

    title('Simulated Annealing: Solução Encontrada');
    xlabel('x');
    ylabel('f(x)');
    legend('f(x)', 'Máximo Global', 'Solução Encontrada', 'Location', 'Best');
    grid on;
    hold off;

