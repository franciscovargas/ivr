function rgbnorm = normalize(img);

img = double(img);
red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);

[height, width, color] = size(img);
norm_img = zeros(height, width, color, 'double');          % TODO normn

for i = 1 : height
    for j = 1 : width
        norm_img(i,j,1) = red(i,j) / (red(i,j) + blue(i,j) + green(i,j));
        norm_img(i,j,2) = green(i,j) / (red(i,j) + blue(i,j) + green(i,j));
        norm_img(i,j,3) = blue(i,j) / (red(i,j) + blue(i,j) + green(i,j));
        if (red(i,j) + blue(i,j) + green(i,j)) == 0
            norm_img(i,j,1) = 0.33333333333333333333333333;
            norm_img(i,j,2) = 0.33333333333333333333333333;
            norm_img(i,j,3) = 0.33333333333333333333333333;
        end
    end
end

rgbnorm = norm_img;