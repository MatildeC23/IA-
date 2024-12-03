function [best_global, best_global_x] = multiple_restart_hill_climbing(max_iterations, step_size, restarts)
    % Verifica se o número de reinícios é válido
    if ~isnumeric(restarts) || restarts <= 0 || mod(restarts, 1) ~= 0
        error('O valor de "restarts" deve ser um número inteiro positivo.');
    end

    % Define o intervalo de busca para plotagem
    x_range = linspace(0, 1.6, 1000);
    f_values = arrayfun(@f1, x_range); % Calcula os valores da função f1

    % Determina o máximo global da função para plotagem
    [global_max_value, idx] = max(f_values);
    global_max_x = x_range(idx);

    % Inicializa as variáveis globais de melhor resultado
    best_global = -Inf;
    best_global_x = NaN;

    % Variáveis para armazenar os caminhos percorridos
    starting_points = []; % Pontos iniciais de cada reinício
    best_local_values = []; % Armazena os melhores valores locais por reinício
    best_global_values = []; % Armazena os melhores valores globais ao longo do tempo
    all_paths_x = []; % Inicializa o vetor para armazenar todos os caminhos x
    all_paths_y = []; % Inicializa o vetor para armazenar todos os caminhos y

    % Loop de múltiplos reinícios
    for restart = 1:restarts
        % Define o ponto de partida aleatório no intervalo [0, 1.6]
        x_current = rand * 1.6;
        starting_points = [starting_points, x_current]; % Armazena o ponto inicial
        best_local = f1(x_current);

        % Inicializa os vetores para este reinício
        path_x = x_current;
        path_y = best_local;

        % Loop de escalada para este reinício
        for iter = 1:max_iterations
            % Gera um ponto vizinho
            x_neighbor = x_current + (rand * 2 - 1) * step_size;

            % Verifica se o vizinho está dentro do intervalo válido
            if x_neighbor >= 0 && x_neighbor <= 1.6
                f_neighbor = f1(x_neighbor);

                % Atualiza para o vizinho se ele tiver um valor maior
                if f_neighbor > best_local
                    best_local = f_neighbor;
                    x_current = x_neighbor;
                end
            end

            % Armazena o ponto atual no caminho
            path_x(end+1) = x_current;
            path_y(end+1) = f1(x_current);
        end

        % Atualiza o melhor resultado global se necessário
        if best_local > best_global
            best_global = best_local;
            best_global_x = x_current;
        end

        % Armazena os melhores valores locais e globais ao longo do tempo
        best_local_values = [best_local_values, best_local];
        best_global_values = [best_global_values, best_global];

        % Armazena os caminhos e resultados dos reinícios no vetor
        all_paths_x = [all_paths_x, path_x];  % Adiciona os valores de x
        all_paths_y = [all_paths_y, path_y];  % Adiciona os valores de f(x)

        % Plota o caminho do reinício com linhas contínuas
        plot(path_x, path_y, 'r-', 'MarkerSize', 6, 'LineWidth', 1.5); 
        hold on;

        % Adiciona marcadores para o início e fim de cada reinício
        plot(path_x(1), path_y(1), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g'); % Início
        plot(path_x(end), path_y(end), 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k'); % Fim
    end

    %% Configura a visualização
    figure;

    % Subplot 1: Função, Máximo Global, Pontos Iniciais e Caminhos
    subplot(1, 2, 1); % Gráfico à esquerda
    plot(x_range, f_values, 'b-', 'LineWidth', 1.5); hold on; % Função f(x) em azul
    plot(global_max_x, global_max_value, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 2); % Máximo global

    % Plota os caminhos de todos os reinícios (usando os vetores)
    plot(all_paths_x, all_paths_y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6, 'LineWidth', 1.5);

    % Plota os pontos iniciais em preto
    for i = 1:length(starting_points)
        plot(starting_points(i), f1(starting_points(i)), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'LineWidth', 2);
    end

    title('Multiple Restart Hill Climbing');
    xlabel('x');
    ylabel('f(x)');
    legend('f(x)', 'Máximo Global', 'Caminhos de Hill Climbing', 'Pontos Iniciais', 'Location', 'Best');
    hold off;

    % Subplot 2: Evolução do Melhor Valor Global
    subplot(1, 2, 2); % Gráfico à direita
    plot(1:restarts, best_local_values, 'r-', 'LineWidth', 1.5); hold on; % Valores locais
    plot(1:restarts, best_global_values, 'b-', 'LineWidth', 1.5); % Valores globais

    % Linha pontilhada preta para o máximo global
    yline(global_max_value, 'k--', 'LineWidth', 2); 

    title('Evolução dos Valores Alcançados');
    xlabel('Reinicializações');
    ylabel('Melhor Valor Alcançado');
    legend('Melhor Local por Reinício', 'Melhor Global', 'Máximo Global', 'Location', 'Best');
    grid on;
    hold off;
end
