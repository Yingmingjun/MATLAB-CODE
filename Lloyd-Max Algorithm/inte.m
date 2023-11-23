
% Example usage
x1 = 0; % Set your lower limit
x2 = 0.4861; % Set your upper limit
distributionType = 'Gaussian'; % Choose 'Gaussian' or 'Rayleigh'
integralResult = calculateCustomIntegral(x1, x2, distributionType);
disp(['Integral result for ', distributionType, ' distribution: ', num2str(integralResult)]);


% Function to calculate the integral
function result = calculateCustomIntegral(x1, x2, distributionType)
    % Define the Gaussian distribution function
    gaussianFunction = @(x) (1/sqrt(2*pi)) * exp(-0.5 * x.^2);

    % Define the Rayleigh distribution function
    % Replace sigma with the desired scale parameter for the Rayleigh distribution
    sigma = 1; 
    rayleighFunction = @(x) (x/(sigma^2)) .* exp(-x.^2 / (2*sigma^2));

    % Choose the distribution based on the input
    if strcmp(distributionType, 'Gaussian')
        p = gaussianFunction;
    elseif strcmp(distributionType, 'Rayleigh')
        p = rayleighFunction;
    else
        error('Unsupported distribution type');
    end

    % Calculate the integral of x * p(x)
    % result = integral(@(x) x .* p(x), x1, x2);
    result = integral(@(x) p(x), x1, x2);
end

