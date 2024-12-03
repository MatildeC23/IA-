function [best_global, best_global_x] = hill_climbing(max_iterations, step_size, restarts)
    % Verifica se restarts é um número válido
    if ~isnumeric(restarts) || restarts <= 0 || mod(restarts, 1) ~= 0
        error('O valor de "restarts" deve ser um número inteiro positivo.');
    end

    % Define o intervalo de busca para plotagem
    x_range = linspace(0, 1.6 , 1000);
    f_values = arrayfun(@f1, x_range);  % Calcula os valores da função f1

    % Determina o máximo global para plotagem
    [global_max_value, idx] = max(f_values);
    global_max_x = x_range(idx);

    % Inicializa as variáveis para acompanhar o melhor resultado encontrado
    best_global = -Inf;
    best_global_x = NaN;

    % Ponto de partida aleatório no intervalo [0, 1.6]
    x_current = rand * 1.6;
    % se quisermos definir o ponto fica : 
    %x_current =  0.6;
    starting_points = x_current;  % Salva o ponto inicial
    best_local = f1(x_current);

    % Armazena o caminho percorrido (inicia com o ponto inicial)
    path_x = x_current;
    path_y = best_local;

    % Loop de escalada
    for iter = 1:max_iterations
        % Gera um ponto vizinho
        x_neighbor = x_current + (rand * 2 - 1) * step_size;

        % Verifica se o vizinho está dentro do intervalo válido
        if x_neighbor >= 0 && x_neighbor <= 1.6
            f_neighbor = f1(x_neighbor);

            % Aceita o vizinho se ele tiver um valor maior
            if f_neighbor > best_local
                best_local = f_neighbor;
                x_current = x_neighbor;
            end
        end

        % Armazena o novo ponto no caminho
        path_x = [path_x, x_current];
        path_y = [path_y, f1(x_current)];
    end

    % Atualiza o melhor global se esta execução encontrou um novo máximo
    if best_local > best_global
        best_global = best_local;
        best_global_x = x_current;
    end

    %% Configura a janela de múltiplos gráficos
    figure;

    % Subplot 1: Função, Máximo Global, Pontos Iniciais e Caminhos
    subplot(1, 2, 1); % Gráfico à esquerda
    plot(x_range, f_values, 'b-', 'LineWidth', 1.5); hold on; % Função f(x) em azul
    plot(global_max_x, global_max_value, 'ko', 'MarkerFaceColor', 'w', 'MarkerSize', 8, 'LineWidth', 2); % Máximo global

    % Plota os pontos vermelhos ao longo do caminho de escalada
    plot(path_x, path_y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6, 'LineWidth', 1.5);  % Caminho em vermelho

    % Plota o único ponto preto para o ponto inicial
    plot(starting_points, f1(starting_points), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'LineWidth', 2); % Ponto inicial

    title('HILL_CLIMING');
    xlabel('x');
    ylabel('f(x)');
    legend('f(x)', 'Máximo Global', 'Hill climbers', 'Ponto inicial', 'Location', 'Best');
    hold off;

    % Subplot 2: Evolução do Máximo Alcançado
    subplot(1, 2, 2); % Gráfico à direita
    iterations = 1:length(path_y); % Contador de iterações

    plot(iterations, path_y, 'r-', 'LineWidth', 1.5); hold on; % Linha sólida vermelha para f(x)
    yline(global_max_value, 'k--', 'LineWidth', 2); % Linha pontilhada preta para o máximo global

    % Traça a evolução de x
    plot(iterations, path_x, 'b-', 'LineWidth', 1.5); % Linha azul para x alcançado
    yline(global_max_x, 'b--', 'LineWidth', 2); % Linha pontilhada azul para x global

    title('Evolução dos Valores Alcançados');
    xlabel('Iterações');
    ylabel('Valores');
    legend('f(x) Alcançado', 'f(x) Máximo Global', 'x Alcançado', 'x Máximo Global', 'Location', 'Best');
    grid on;
    hold off;
end

