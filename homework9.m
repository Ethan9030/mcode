img = imread('peppers.png');
img = rgb2gray(img);
img = im2double(img);

[rows, cols] = size(img);
n = 10;

X = zeros(rows*cols, n);

for i = 1:n
    noisy = imnoise(img, 'gaussian', 0, 0.01);
    X(:,i) = reshape(noisy, [], 1);
end

C = cov(X);

[V, D] = eig(C);

[eigenvalues, index] = sort(diag(D), 'descend');
V = V(:, index);

X_mean = mean(X, 1);
X_centered = X - X_mean;

Y = X_centered * V;

k = 4;
Y(:, k+1:end) = 0;

X_new = Y * V' + X_mean;

noisy_img = reshape(X(:,1), rows, cols);
result_img = reshape(X_new(:,1), rows, cols);

result_img = max(0, min(1, result_img));

figure;

subplot(1,3,1);
imshow(img);
title('Original Image');

subplot(1,3,2);
imshow(noisy_img);
title('Noisy Image');

subplot(1,3,3);
imshow(result_img);
title('PCA Denoised Image');