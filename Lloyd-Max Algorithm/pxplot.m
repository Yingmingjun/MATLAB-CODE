% Define the range of x values for plotting
x_values = -5:0.1:5; % For Gaussian
x_values_rayleigh = 0:0.1:5; % For Rayleigh, non-negative values

% Gaussian PDF parameters
mu = 0; % mean
sigma = 1; % standard deviation
gaussian_pdf = @(x) exp(-(x - mu).^2 / (2 * sigma^2)) / (sigma * sqrt(2 * pi));

% Calculate Gaussian PDF over x values
gaussian_values = arrayfun(gaussian_pdf, x_values);

% Rayleigh PDF parameters
sigma_rayleigh = 1; % scale parameter
rayleigh_pdf = @(x) (x / sigma_rayleigh^2) .* exp(-x.^2 / (2 * sigma_rayleigh^2));

% Calculate Rayleigh PDF over x values
rayleigh_values = arrayfun(rayleigh_pdf, x_values_rayleigh);

% Create subplot for Gaussian PDF
subplot(1, 2, 1);
plot(x_values, gaussian_values, 'b', 'LineWidth', 2);
title('Gaussian PDF');
xlabel('x');
ylabel('Probability Density');
grid on;


gaussian_formula = '$$ \frac{1}{\sigma\sqrt{2\pi}}e^{-\frac{(x-\mu)^2}{2\sigma^2}} $$';
text(-4, 0.3, gaussian_formula, 'Interpreter', 'latex', 'FontSize', 20, 'Color', 'blue','HorizontalAlignment', 'right', 'VerticalAlignment', 'top');

% Create subplot for Rayleigh PDF
subplot(1, 2, 2);
plot(x_values_rayleigh, rayleigh_values, 'r', 'LineWidth', 2);
title('Rayleigh PDF');
xlabel('x');
ylabel('Probability Density');
grid on;


rayleigh_formula = '$$ \frac{x}{\sigma^2}e^{-\frac{x^2}{2\sigma^2}} $$';
text(1, 0.3, rayleigh_formula, 'Interpreter', 'latex', 'FontSize', 20, 'Color', 'red','HorizontalAlignment', 'right', 'VerticalAlignment', 'top');

% Adjust subplot spacing
% set(gcf, 'Position', [500, 500, 1049, 895]); % Adjust the size of the figure
