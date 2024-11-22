function y = f1(x)
    % Condição para restringir o domínio
    if x < 0 || x > 1.6
        error('x está fora do intervalo permitido [0, 1.6]');
    end
    
    % Função principal
    y = 4 * sin(5 * pi * x + 0.5)^6 * exp(log2((x - 0.8)^2));
end

