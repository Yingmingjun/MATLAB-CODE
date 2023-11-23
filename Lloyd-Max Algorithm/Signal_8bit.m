clear 
clc
close all
% Step 1: Generate a simulated signal
Fs = 500; % Sampling frequency
t = 0:1/Fs:1; % Time vector
signal = sin(2 * pi * 15 * t) + sin(2 * pi * 40 * t); % Generate a signal with two frequencies

% Step 2: Estimate the Probability Density Function (PDF) of the signal
[counts, bins] = hist(signal, 100);
pdf = @(x) interp1(bins, counts / sum(counts), x, 'linear', 0);

% Step 3: Apply Lloyd-Max quantization
M = 8; % Number of quantization levels
threshold = 1e-5; % Convergence threshold
Xmin = min(signal);
Xmax = max(signal);
[quantizedLevels, ~] = lloyd_max(M, pdf, Xmin, Xmax, threshold);

% Step 4: Quantize the signal
quantizedSignal = arrayfun(@(x) quantizeToLevel(x, quantizedLevels), signal);

% Step 5: Display the original signal and the quantized signal on the same graph
figure;
plot(t, signal, 'LineWidth', 1.5); % Original signal
hold on;
stairs(t, quantizedSignal, 'r-', 'LineWidth', 1.5); % Quantized signal
title('Original and Quantized Signals (8-level Lloyd-Max)');
xlabel('Time');
ylabel('Amplitude');
legend('Original Signal', 'Quantized Signal');
xlim([0, 0.1]); % Limiting the x-axis to show only the first second

% Helper function: Quantize a single data point to the nearest level
function level = quantizeToLevel(x, levels)
    [~, idx] = min(abs(x - levels));
    level = levels(idx);
end
