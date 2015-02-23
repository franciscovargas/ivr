function rgbnorm = normalize(img);

red = img(:, :, 1);
green = img(:, :, 2);
blue = img(:, :, 3);

[height, width, color] = size(img);
normm = zeros(height, width, color, 'double');
for i = 1 : height
    for j = 1 : width
        normm(i,j,1) = double(red(i,j)) / double( red(i,j) + blue(i,j) + green(i,j));
        normm(i,j,2) = double(green(i,j)) / double( red(i,j) + blue(i,j) + green(i,j));
        normm(i,j,3) = double(blue(i,j)) / double( red(i,j) + blue(i,j) + green(i,j));
    end
end

rgbnorm = normm;
