function rgbnorm = normalize(img);
img = double(img);
red = img(:,:,1);
green = img(:,:,2);
blue = img(:,:,3);

[height, width, color] = size(img);
normm = zeros(height,width,color,'double');
for i=1:height
    for j=1:width
    	% the prints bellow print non zero results
    	% disp(double(red(i,j)) / double( red(i,j)+ blue(i,j)+green(i,j)));
    	% disp(double(double( red(i,j)+ blue(i,j)+green(i,j))));
        normm(i,j,1) = red(i,j) / (red(i,j)+ blue(i,j)+green(i,j));
        normm(i,j,2) = green(i,j) / (red(i,j)+ blue(i,j)+green(i,j));
        normm(i,j,3) = blue(i,j) / (red(i,j)+ blue(i,j)+green(i,j));
    end
end
% figure
% imshow(normm)
rgbnorm = normm;