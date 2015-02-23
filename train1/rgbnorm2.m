function rgbnorm = normalize(img);

img = double(img);
red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);

[height, width, color] = size(img);
normn = zeros(height, width, color, 'double');

for i = 1 : height
    for j = 1 : width
        normn(i,j,1) = red(i,j) / (red(i,j) + blue(i,j) + green(i,j));
        normn(i,j,2) = green(i,j) / (red(i,j) + blue(i,j) + green(i,j));
        normn(i,j,3) = blue(i,j) / (red(i,j) + blue(i,j) + green(i,j));
    end
end

rgbnorm = normn;