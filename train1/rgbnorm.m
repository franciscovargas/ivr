function rgbnorm = normalize(img);
red = img(:,:,1);
blue = img(:,:,2);
green = img(:,:,3);
[height, width, color] = size(img);
normm = zeros(height,width,color,'double');
for i=1:height
    for j=1:width
    	% disp(double(red(i,j)) / double( red(i,j)+ blue(i,j)+green(i,j)));
    	% disp(double(double( red(i,j)+ blue(i,j)+green(i,j))));
        normm(i:j:1) = double(red(i,j)) / double( red(i,j)+ blue(i,j)+green(i,j));
        normm(i:j:2) = double(green(i,j)) / double( red(i,j)+ blue(i,j)+green(i,j));
        normm(i:j:3) = double(blue(i,j)) / double( red(i,j)+ blue(i,j)+green(i,j));
    end
end
disp(normm);
rgbnorm = normm;