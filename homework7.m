img = imread("peppers.png");
img = rgb2gray(img);
img = im2double(img);

noise = 0.08 * randn(size(img));
noisy_img = img + noise;

noisy_img(noisy_img > 1) = 1;
noisy_img(noisy_img < 0) = 0;

%% Part A

sigma = 1.5;

[x5, y5] = meshgrid(-2:2, -2:2);

h5 = exp(-(x5.^2 + y5.^2) / (2*sigma^2));
h5 = h5 / sum(h5(:));

result5 = conv2(noisy_img, h5, 'same');

[x7, y7] = meshgrid(-3:3, -3:3);

h7 = exp(-(x7.^2 + y7.^2) / (2*sigma^2));
h7 = h7 / sum(h7(:));

result7 = conv2(noisy_img, h7, 'same');

[x9, y9] = meshgrid(-4:4, -4:4);

h9 = exp(-(x9.^2 + y9.^2) / (2*sigma^2));
h9 = h9 / sum(h9(:));

result9 = conv2(noisy_img, h9, 'same');

figure;

subplot(2,3,1);
imshow(img);
title('Original Image');

subplot(2,3,2);
imshow(noisy_img);
title('Image with Noise');

subplot(2,3,3);
imshow(result5);
title('5 x 5 Gaussian');

subplot(2,3,4);
imshow(result7);
title('7 x 7 Gaussian');

subplot(2,3,5);
imshow(result9);
title('9 x 9 Gaussian');

sgtitle('Gaussian Filtering in Spatial Domain');


%% Part B

sigma35 = 5;

[x35, y35] = meshgrid(-17:17, -17:17);

h35 = exp(-(x35.^2 + y35.^2) / (2*sigma35^2));
h35 = h35 / sum(h35(:));

tic;

spatial35 = conv2(noisy_img, h35, 'same');

time_spatial = toc;

tic;

[M, N] = size(noisy_img);
[m, n] = size(h35);

P = M + m - 1;
Q = N + n - 1;

F = fft2(noisy_img, P, Q);
F = fftshift(F);

H = fft2(h35, P, Q);
H = fftshift(H);

G = F .* H;

G = ifftshift(G);

result_full = real(ifft2(G));

start_row = floor(m/2) + 1;
start_col = floor(n/2) + 1;

frequency35 = result_full(start_row:start_row+M-1,start_col:start_col+N-1);


time_frequency = toc;

figure;

subplot(1,3,1);
imshow(noisy_img);
title('Noisy Image');

subplot(1,3,2);
imshow(spatial35);
title('35 x 35 Spatial Domain');

subplot(1,3,3);
imshow(frequency35);
title('35 x 35 Frequency Domain');

sgtitle('Spatial Domain vs Frequency Domain');

fprintf('Spatial domain time: %.6f seconds\n', time_spatial);
fprintf('Frequency domain time: %.6f seconds\n', time_frequency);