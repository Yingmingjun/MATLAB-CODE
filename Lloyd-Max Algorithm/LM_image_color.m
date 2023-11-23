clear 
clc
close all

% Read the RGB image
rgbImage = imread('image1.jpg');

% Set quantization parameters
levelCounts = [4, 8, 16]; % Levels for quantization
threshold = 1e-4; % Convergence threshold

% Create a figure for all subplots
figure;

% Display the original image in the first subplot
subplot(2, 2, 1);
imshow(rgbImage);
title('Original Image');

for i = 1:length(levelCounts)
    M = levelCounts(i);

    % Quantize each channel using vectorized operations
    quantizedImage = rgbImage; % Initialize with original image
    for channel = 1:3
        % Extract the channel
        channelData = double(rgbImage(:,:,channel));

        % Compute the histogram and PDF
        [histData, binData] = imhist(uint8(channelData));
        pdfFunc = @(x) interp1(binData, histData / numel(channelData), x, 'linear', 0);

        % Apply Lloyd-Max algorithm
        [levels, ~] = lloyd_max(M, pdfFunc, min(channelData(:)), max(channelData(:)), threshold);

        % Create lookup table and quantize the channel
        LUT = createLUT(levels);
        quantizedImage(:,:,channel) = uint8(LUT(uint8(channelData)+1));
    end

    % Display the quantized image in a subplot
    subplot(2, 2, i + 1);
    imshow(quantizedImage);
    title(['Levels: ', num2str(M)]);
end

sgtitle('Original and Quantized Images with Different Levels');

% Save the entire figure with all subplots
savefig('quantized_color_images1.fig');


% Helper function to create a lookup table for quantization
function LUT = createLUT(levels)
    LUT = zeros(256, 1, 'uint8');
    for i = 1:256
        [~, idx] = min(abs(i-1 - levels));
        LUT(i) = uint8(levels(idx));
    end
end
