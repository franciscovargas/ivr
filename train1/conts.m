
function conts = countours(img)
%{
   -- This function takes in a binary
   image and proceeds to find regions
   within such image.
   -- The thresholding/edge detection
   is left to be done prior to this 
   function.
%}

% dimensions
[height width] = size(img);

% display image
imshow(img)

% lable connecteded elements
[lable na] = bwlabel(img);

% calculate the properties of the regions
% within the image
property = regionprops(lable);

% TO DO. Center of mass calculation
[y x] = find(img);
cent = [mean(x) mean(y)];

% Retain current plots when adding new plots
hold on

% draw the bounding boxes in the image
[none asize] = size([property.Area]);
area = zeros(none, asize);

for n=1:size(property, 1)

    rectangle('Position', ...
              property(n).BoundingBox, ...
              'EdgeColor', ...
              'g', ...
              'LineWidth', ...
              2);
    area(n) = property(n).BoundingBox(3) * property(n).BoundingBox(4);
end

% find areas smaller than 200
small_areas=find([property.Area]<200);

% display areas (in red) smaller than 200
for n=1:size(small_areas,2)

    rectangle('Position', ...
    	        property(small_areas(n)).BoundingBox, ...
    		      'EdgeColor', ...
              'r', ...
              'LineWidth', ...
              2);
end

% remove the small areas
for n=1:size(small_areas,2)

    coord=round(property(small_areas(n)).BoundingBox);

    img(coord(2): coord(2) + coord(4), coord(1): coord(1) + coord(3)) = 0;
end

figure
imshow(img)

% array structure 'out' containing:

% default region properties
out.prop = property;

% noise cleaned binary image
out.bw = img;

% areas of BoundingBoxes
out.boxarea = area;

conts = out;
