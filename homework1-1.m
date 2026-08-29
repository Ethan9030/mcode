% Read the attached image (gray level and color image)
colorimg = imread("peppers.png");

grayimg = rgb2gray(colorimg);

% color image:

[rows, columns, channels] = size(colorimg);
% horizontal flip
hor_colorimg = zeros(size(colorimg),'like',colorimg);
for i = 1 : rows
    for j = 1 : columns
        for k = 1 : channels
            hor_colorimg(i, columns-j+1, k) = colorimg(i, j, k);
        end
    end
end

% vertical flip
ver_colorimg = zeros(size(colorimg),'like',colorimg);
for i = 1 : rows
    for j = 1 : columns
        for k = 1 : channels
            ver_colorimg(rows-i+1, j, k) = hor_colorimg(i, j, k);
        end
    end
end

colorimg_inv = imcomplement(ver_colorimg);

% Display the transformed image
figure;
imshow(colorimg_inv);

imwrite(colorimg_inv,'inver_colorpeppers.jpg');

% gray image:

[rows, columns] = size(grayimg);

% horizontal flip

hor_grayimg = zeros(size(grayimg),'like',grayimg);

for i = 1 : rows
    for j = 1 : columns
        hor_grayimg(i, columns-j+1) = grayimg(i, j);
    end
end

% vertical flip

ver_grayimg = zeros(size(grayimg),'like',grayimg);
for i = 1 : rows
    for j = 1 : columns
        ver_grayimg(rows-i+1, j) = hor_grayimg(i, j);
    end
end

% invert the gray image

grayimg_inv = imcomplement(ver_grayimg);

% Display the transformed image

figure;

imshow(grayimg_inv);
imwrite(grayimg_inv,'inver_graypeppers.jpg');