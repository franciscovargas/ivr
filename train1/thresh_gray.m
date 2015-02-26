function thresh = threshold(value)

    % Dimensions of the image
    [height width channels] = size(value);

    % Gray scale of image
    gray_img = rgb2gray(value);

    % Set up bins for histogram
    edges = linspace(0, 255, 256);

    % Flatten values in redscale the two
    % last parameters of reshape
    % define the new dimensions of vecr
    vecr = reshape(gray_img, 1, width*height);

    % Find histogram
    histr = histc(vecr, edges);                     % TODO histc not recommended in MathWorks

    % Length of the Gaussian kernel
    sizeparam = 40;

    % Use findtfeat to find threshold values
    upper_thresh = findtfeat(histr, edges, sizeparam, 0);

    [height, width, color] = size(gray_img);
    threshed_img = zeros(height, width);

    % Threshold every pixel in the image
    for row = 1 : height
        for col = 1 : width
            if gray_img(row, col) < upper_thresh...   % inside high boundary
            & gray_img(row, col) >= 0                 % optional low boundary
                threshed_img(row, col) = 1;
            else
                threshed_img(row, col) = 0;
            end
        end
    end

    % Return value of the function
    thresh = threshed_img;
