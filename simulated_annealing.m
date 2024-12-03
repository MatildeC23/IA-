function [best_global, best_global_x] = simulated_annealing(max_iterations, T, nRep, alfa, step_size)

    % Definir o intervalo e a função alvo
    x_range = linspace(0, 1.6, 1000); % Intervalo [0, 1.6] dividido em 1000 pontos
    f_values = arrayfun(@f1, x_range); % Avaliar f(x) para o intervalo definido

    % Determinar o máximo global para referência
    [global_max_value, idx] = max(f_values);
    global_max_x = x_range(idx);

    % Selecionar um ponto inicial aleatório no intervalo [0, 1.6]
    x_current = rand * 1.6;
    f_current = f1(x_current);

    % Inicializar o melhor global
    best_global_x = x_current;
    best_global = f_current;

    % Armazenar histórico para plotagem
    temperature_history = zeros(1, max_iterations * nRep);
    best_history = zeros(1, max_iterations * nRep);
    delta_energy_history = zeros(1, max_iterations * nRep);
    probability_history = zeros(1, max_iterations * nRep);
    x_history = zeros(1, max_iterations * nRep);
    f_history = zeros(1, max_iterations * nRep);

    iter_count = 0; % Contador de iterações total para histórico

    % Início do loop de Simulated Annealing
    for iter = 1:max_iterations
        for rep = 1:nRep
            iter_count = iter_count + 1; % Atualizar contador de iterações

            % Gerar um vizinho aleatório
          x_neighbor = max(0, min(1.6, x_current + (rand * 2 - 1) * step_size));


            % Verificar se o vizinho está dentro do intervalo permitido
            if x_neighbor >= 0 && x_neighbor <= 1.6
                f_neighbor = f1(x_neighbor);
                dE = f_neighbor - f_current;

                % Probabilidade de aceitação
                if T > 0
                    p = exp(-abs(dE) / T); % Usando a definição padrão de Simulated Annealing
                else
                    p = 0;
                end

                % Verificar se aceita o vizinho
                if dE > 0 || rand < p
                    x_current = x_neighbor;
                    f_current = f_neighbor;

                    % Atualizar o melhor global
                    if f_current > best_global
                        best_global_x = x_current;
                        best_global = f_current;
                    end
                end

                % Registrar delta de energia e probabilidade
                delta_energy_history(iter_count) = dE;
                probability_history(iter_count) = p;
            else
                % Caso o vizinho esteja fora do intervalo, manter valores
                delta_energy_history(iter_count) = NaN;
                probability_history(iter_count) = NaN;
            end

            % Atualizar histórico
            temperature_history(iter_count) = T;
            best_history(iter_count) = best_global;
            x_history(iter_count) = x_current;
            f_history(iter_count) = f_current;
        end

        % Atualizar a temperatura
        T = alfa * T;
    end

    %% Gráficos do Simulated Annealing
    figure;

    % Gráfico 1: Evolução da temperatura
    subplot(2, 3, 1);
    plot(1:iter_count, temperature_history(1:iter_count), 'b-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('Temperatura (T)');
    title('Evolução da Temperatura');
    grid on;

    % Gráfico 2: Evolução do delta de energia (\Delta E)
    subplot(2, 3, 2);
    plot(1:iter_count, delta_energy_history(1:iter_count), 'g-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('\Delta E');
    title('Evolução do \Delta E');
    grid on;

    % Gráfico 3: Probabilidade  (p)
    subplot(2, 3, 3);
    plot(1:iter_count, probability_history(1:iter_count), 'm-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('Probabilidade (p)');
    title('Probabilidade ');
    grid on;

    % Gráfico 4: Evolução do valor de f(x)
    subplot(2, 3, 4);
    plot(1:iter_count, f_history(1:iter_count), 'r-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('f(x)');
    title('Evolução de f(x)');
    grid on;

    % Gráfico 5: Evolução do valor de x
    subplot(2, 3, 5);
    plot(1:iter_count, x_history(1:iter_count), 'c-', 'LineWidth', 1.5);
    xlabel('Iterações');
    ylabel('x');
    title('Evolução de x');
    grid on;

    % Gráfico 6: Função objetivo com máximo global e solução encontrada
    subplot(2, 3, 6);
    plot(x_range, f_values, 'b-', 'LineWidth', 1.5); hold on;
    plot(global_max_x, global_max_value, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 2);
    plot(best_global_x, best_global, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8, 'LineWidth', 2);
    title('Simulated Annealing: Solução Encontrada');
    xlabel('x');
    ylabel('f(x)');
    legend('f(x)', 'Máximo Global', 'Solução Encontrada', 'Location', 'Best');
    grid on;
    hold off;
end
