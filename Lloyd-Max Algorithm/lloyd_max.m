function [quantizedLevels, decisionBoundaries] = lloyd_max(M, p, Xmin, Xmax, threshold)
    % Initialize decision boundaries and quantization levels
    decisionBoundaries = linspace(Xmin, Xmax, M + 1);
    quantizedLevels = (decisionBoundaries(1:end-1) + decisionBoundaries(2:end)) / 2;
    
    % Iterative optimization
    delta = Inf;
    while delta > threshold
        oldQuantizedLevels = quantizedLevels;
        
        % Update quantization levels (centroids)
        for q = 1:M
            num = integral(@(x) x .* p(x), decisionBoundaries(q), decisionBoundaries(q + 1));
            den = integral(p, decisionBoundaries(q), decisionBoundaries(q + 1));
            quantizedLevels(q) = num / den;
        end

        % Update decision boundaries (midpoints)
        for q = 2:M
            decisionBoundaries(q) = (quantizedLevels(q - 1) + quantizedLevels(q)) / 2;
        end

        % Check for convergence
        delta = max(abs(quantizedLevels - oldQuantizedLevels));
    end
end
