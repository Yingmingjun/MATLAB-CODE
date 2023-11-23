% Function Definitions for lloyd_max, max_entropy, binarySearchBoundary
% (Insert the definitions of your lloyd_max, max_entropy, and binarySearchBoundary functions here)

% Image file paths
imageFiles = {'image1.jpg', 'image2.jpg', 'image3.jpg'};

% Create a figure for the 3x3 grid
figure;

% Loop through each image file
for i = 1:length(imageFiles)
    % Read the image
    image = imread(imageFiles{i});

    % Convert to grayscale if it's a color image
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % Flatten the image for processing
    imageVector = double(image(:));

    % Estimate PDF from the image data
    [counts, bins] = hist(imageVector, 256);
    pdf = @(x) interp1(bins, counts / sum(counts), x, 'linear', 0);

    % Quantization parameters
    M = 8; % 8-level quantization
    threshold = 1e-4; % Convergence threshold
    Xmin = min(imageVector);
    Xmax = max(imageVector);

    % Apply Lloyd-Max Quantization
    [quantizedLevelsLloyd, ~] = lloyd_max(M, pdf, Xmin, Xmax, threshold);

    % Apply Max Entropy Quantization
    [quantizedLevelsEntropy, ~] = max_entropy(M, pdf, Xmin, Xmax, threshold);

    % Quantize the image
    quantizedImageLloyd = mapToQuantized(imageVector, quantizedLevelsLloyd);
    quantizedImageEntropy = mapToQuantized(imageVector, quantizedLevelsEntropy);

    % Reshape the quantized images back to the original size
    quantizedImageLloyd = reshape(quantizedImageLloyd, size(image));
    quantizedImageEntropy = reshape(quantizedImageEntropy, size(image));

    % Display the results
    subplot(3, 3, (i-1)*3+1);
    imshow(image);
    title(['Original Image ' num2str(i)]);

    subplot(3, 3, (i-1)*3+2);
    imshow(uint8(quantizedImageLloyd));
    title(['Lloyd-Max Quantized Image ' num2str(i)]);

    subplot(3, 3, (i-1)*3+3);
    imshow(uint8(quantizedImageEntropy));
    title(['Max Entropy Quantized Image ' num2str(i)]);
end

% Function to map image data to quantized levels
function quantizedImage = mapToQuantized(imageVector, quantizedLevels)
    quantizedImage = zeros(size(imageVector));
    for j = 1:length(imageVector)
        [~, idx] = min(abs(quantizedLevels - imageVector(j)));
        quantizedImage(j) = quantizedLevels(idx);
    end
end
