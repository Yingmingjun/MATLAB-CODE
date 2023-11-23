function [quantizedLevels, decisionBoundaries] = max_entropy(M, p, Xmin, Xmax, threshold)
    % Number of points for the CDF lookup table
    numPoints = 10000; % Increased number of points for higher resolution
    
    % Create CDF lookup table
    xValues = linspace(Xmin, Xmax, numPoints);
    cdfValues = zeros(1, numPoints);
    for i = 1:numPoints
        cdfValues(i) = integral(p, Xmin, xValues(i), 'AbsTol', 1e-10, 'RelTol', 1e-10);
    end

    % Initialize decision boundaries
    decisionBoundaries = linspace(Xmin, Xmax, M + 1);
    quantizedLevels = zeros(1, M);

    % Target CDF value for each interval
    targetCDFIncrement = 1 / M;

    % Iterative optimization
    delta = Inf;
    while delta > threshold
        oldQuantizedLevels = quantizedLevels;

        % Update decision boundaries to equalize probability mass
        for q = 2:M
            targetCDFValue = cdfValues(1) + (q - 1) * targetCDFIncrement;
            decisionBoundaries(q) = binarySearchBoundary(xValues, cdfValues, decisionBoundaries(q - 1), decisionBoundaries(q + 1), targetCDFValue);
        end

        % Calculate quantized levels (centroids) for each interval
        for q = 1:M
            num = integral(@(x) x .* p(x), decisionBoundaries(q), decisionBoundaries(q + 1), 'ArrayValued', true, 'AbsTol', 1e-10, 'RelTol', 1e-10);
            den = interp1(xValues, cdfValues, decisionBoundaries(q + 1)) - interp1(xValues, cdfValues, decisionBoundaries(q));
            quantizedLevels(q) = num / den;
        end

        % Check for convergence
        delta = max(abs(quantizedLevels - oldQuantizedLevels));
    end
end

function boundary = binarySearchBoundary(xValues, cdfValues, left, right, targetCDFValue)
    tolerance = 1e-6; % Reduced tolerance for higher precision
    while right - left > tolerance
        mid = (left + right) / 2;
        midCDF = interp1(xValues, cdfValues, mid, 'linear');
        if midCDF < targetCDFValue
            left = mid;
        else
            right = mid;
        end
    end
    boundary = (left + right) / 2;
end
