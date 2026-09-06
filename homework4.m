img = imread('peppers.png');

scale = 4;

my_result = BilinearResize(img, scale);

mat_result = imresize(img, scale, 'bilinear');

figure;
imshow(img);
title('Original Image');

figure;
imshow(my_result);
title('My Bilinear Interpolation');

figure;
imshow(mat_result);
title('MATLAB imresize');

difference = abs(double(my_result) - double(mat_result));

fprintf('Maximum difference = %.2f\n', max(difference(:)));
fprintf('Mean difference = %.4f\n', mean(difference(:)));

function output = BilinearResize(img, scale)

    [oldRows, oldCols, channels] = size(img);

    newRows = round(oldRows * scale);
    newCols = round(oldCols * scale);

    imgDouble = double(img);

    outputDouble = zeros(newRows, newCols, channels);

    for newRow = 1:newRows
        for newCol = 1:newCols

            oldY = (newRow - 0.5) / scale + 0.5;
            oldX = (newCol - 0.5) / scale + 0.5;

            oldY = max(1, min(oldY, oldRows));
            oldX = max(1, min(oldX, oldCols));

            y1 = floor(oldY);
            x1 = floor(oldX);

            y2 = min(y1 + 1, oldRows);
            x2 = min(x1 + 1, oldCols);

            dy = oldY - y1;
            dx = oldX - x1;

            for c = 1:channels

                topLeft = imgDouble(y1, x1, c);
                topRight = imgDouble(y1, x2, c);
                bottomLeft = imgDouble(y2, x1, c);
                bottomRight = imgDouble(y2, x2, c);

                outputDouble(newRow, newCol, c) = (1-dx)*(1-dy)*topLeft + dx*(1-dy)*topRight + (1-dx)*dy*bottomLeft + dx*dy*bottomRight;
            end
        end
    end

    if isinteger(img)
        output = cast(round(outputDouble), class(img));
    else
        output = cast(outputDouble, class(img));
    end
end