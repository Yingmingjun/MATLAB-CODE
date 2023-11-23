% Read and convert an image to grayscale
image = rgb2gray(imread('image1.jpg'));

% Flatten the image
imageData = double(image(:));

% Compute histogram and empirical PDF
[counts, bins] = hist(imageData, 256);
pdf = @(x) interp1(bins, counts / sum(counts), x, 'linear', 0);

% Parameters
threshold = 1e-5;
Xmin = min(imageData);
Xmax = max(imageData);

% Level counts for comparison
levelCounts = [4, 8, 16];

% Prepare figure
figure;

% Display the original image in the first subplot
subplot(2, 2, 1);
imshow(image);
title('Original Image');

for i = 1:length(levelCounts)
    M = levelCounts(i); % Current number of quantization levels

    % Apply Lloyd-Max algorithm
    [levels, ~] = lloyd_max(M, pdf, Xmin, Xmax, threshold);

    % Quantize image data
    quantizedImageData = arrayfun(@(x) quantizeToLevel(x, levels), imageData);

    % Reshape back to image size
    quantizedImage = reshape(uint8(quantizedImageData), size(image));

    % Display the quantized image
    subplot(2, 2, i + 1); % Adjust subplot position
    imshow(quantizedImage);
    title([num2str(M) '-Level Quantized Image']);
end

% Function to quantize a single data point to the nearest level
function level = quantizeToLevel(x, levels)
    index = find(x <= levels, 1);
    if isempty(index)
        level = levels(end); % Assign to the last level if not found
    else
        level = levels(index);
    end
end
