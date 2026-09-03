img = imread("peppers.png");

grayImg = rgb2gray(img);

x = double(grayImg);

% [c1,c2,c3,c4]
params = [
    0 0 0 0;
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1
    ];

figure;
subplot(2,3,1);
imshow(grayImg);
title('Gray Image');

for k = 1:size(params,1)

    c1 = params(k,1);
    c2 = params(k,2);
    c3 = params(k,3);
    c4 = params(k,4);

    R = x .* (1 + c1 .* sin(pi .* x ./ 255) + c2 .* (1 - cos(2 .* pi .* x ./ 255)));

    G = x .* (1 + c3 .* sin(pi .* x ./ 255) + c4 .* (1 - cos(2 .* pi .* x ./ 255)));

    B = 3 .* x - R - G;

    R = 255 .* (R - min(R(:))) ./ (max(R(:)) - min(R(:)) + eps);

    G = 255 .* (G - min(G(:))) ./ (max(G(:)) - min(G(:)) + eps);

    B = 255 .* (B - min(B(:))) ./ (max(B(:)) - min(B(:)) + eps);

    R = uint8(R);
    G = uint8(G);
    B = uint8(B);

    pseudoColor = cat(3, R, G, B);

    subplot(2,3,k+1);
    imshow(pseudoColor);
    title(sprintf('%.1f %.1f %.1f %.1f', c1,c2,c3,c4));

end