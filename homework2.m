img = imread("peppers.png");

img = rgb2gray(img);

[row, col] = size(img);

histogram_manual = zeros(1, 256);

for i = 1:row
    for j = 1:col
        gray_level = double(img(i,j));
        histogram_manual(gray_level + 1) = ...
            histogram_manual(gray_level + 1) + 1;
    end
end

figure;

subplot(1, 3, 1);
imshow(img); 
title('Grayscale Image');

subplot(1, 3, 2);
plot(0:255, histogram_manual);
xlim([0 255]);
xlabel('Gray Level');
ylabel('Number of Pixels');
title('Manual Histogram');

subplot(1, 3, 3);
imhist(img);
title('Histogram Using imhist()');