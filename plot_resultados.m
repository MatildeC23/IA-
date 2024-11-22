function plot_resultados(hc_best_value, hc_best_x, sa_best_value, sa_best_x)
    % Define o intervalo de x para o gráfico
    x = linspace(0, 1.6, 1000); % Intervalo contínuo no domínio da função
    y = arrayfun(@f1, x);        % Avaliação da função para cada ponto x
    
    % Plota a curva da função
    plot(x, y, 'b-', 'LineWidth', 1.5, 'DisplayName', 'f(x)');
    hold on;
    
    % Marca os máximos encontrados por Hill Climbing e Simulated Annealing
    plot(hc_best_x, hc_best_value, 'ro', 'MarkerSize', 8, 'LineWidth', 1.5, ...
         'DisplayName', 'Hill Climbing');
    plot(sa_best_x, sa_best_value, 'go', 'MarkerSize', 8, 'LineWidth', 1.5, ...
         'DisplayName', 'Simulated Annealing');
    
    % Configurações do gráfico
    legend show;
    xlabel('x');
    ylabel('f(x)');
    title('Resultados da Otimização');
    
    % Ajusta limites dos eixos para melhor visualização
    xlim([0, 1.6]); % Limites de x baseados no domínio
    ylim([min(y) - 0.1, max(y) + 0.1]); % Ajusta os limites de y dinamicamente
    
    % Finaliza o gráfico
    grid on;
    hold off;
end
