I = imread('peppers.png');

noiseDensity = 0.05;   % 5% salt & pepper noise
I_noisy = imnoise(I, 'salt & pepper', noiseDensity);

I_med3 = medianFilterRGB(I_noisy, 3);
I_med5 = medianFilterRGB(I_noisy, 5);
I_med7 = medianFilterRGB(I_noisy, 7);

figure;

subplot(2,3,1);
imshow(I);
title('Original Image');

subplot(2,3,2);
imshow(I_noisy);
title('Salt & Pepper Noise');

subplot(2,3,3);
imshow(I_med3);
title('Median Filter 3x3');

subplot(2,3,4);
imshow(I_med5);
title('Median Filter 5x5');

subplot(2,3,5);
imshow(I_med7);
title('Median Filter 7x7');

function output = medianFilterRGB(input, windowSize)

    % Half size of the window
    padSize = floor(windowSize / 2);

    % Create output image
    output = zeros(size(input), 'like', input);

    % Process R, G, B channels separately
    for c = 1:3

        % Get one color channel
        channel = input(:,:,c);

        % Add padding around the image
        padded = padarray(channel,[padSize padSize],'symmetric');

        % Get image size
        [rows, cols] = size(channel);

        % Move the window over all pixels
        for row = 1:rows

            for col = 1:cols

                % Get current window
                window = padded( ...
                    row : row + windowSize - 1, ...
                    col : col + windowSize - 1);

                % Find the median value
                medianValue = median(window(:));

                % Replace current pixel with median value
                output(row, col, c) = medianValue;

            end

        end

    end

end