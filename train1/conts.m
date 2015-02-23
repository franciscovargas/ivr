
function conts = countours(img, show)
%{
   -- This function takes in a binary
   image and proceeds to find regions
   within such image.
   -- The thresholding/edge detection
   is left to be done prior to this 
   function.
%}

% Dimensions
[height width] = size(img);

if show == 1
  figure
  imshow(img)
end

% Lable connecteded elements
[lable none] = bwlabel(img);

% Calculate the properties of the regions
% within the image
property = regionprops(lable, 'all');

% Retain current plots when adding new plots
if show == 1
  hold on
end

% Draw the bounding boxes in the image
[none asize] = size([property.Area]);
area = zeros(none, asize);

for n = 1 : size(property, 1)
  if show == 1
    rectangle('Position', ...
              property(n).BoundingBox, ...
              'EdgeColor', ...
              'g', ...
              'LineWidth', ...
              2);
  end
  % convex = property(n).ConvexHull;
  % x = convex(:,1);
  % y = convex(:,2);
  % plot(x,y,'b');
  area(n) = property(n).BoundingBox(3) * property(n).BoundingBox(4);
end

% Find areas smaller than 200
small_areas = find([property.Area] < 200);

% Display areas (in red) smaller than 200
for n = 1 : size(small_areas, 2)
  if show == 1
    rectangle('Position', ...
              property(small_areas(n)).BoundingBox, ...
              'EdgeColor', ...
              'r', ...
              'LineWidth', ...
              2);
  end
end

% Remove the small areas
for n = 1 : size(small_areas, 2)
  
  coord = round(property(small_areas(n)).BoundingBox);

  img(coord(2): coord(2) + coord(4), coord(1): coord(1) + coord(3)) = 0;
end

% Array structure 'out' containing:

% default region properties
out.prop = property;

% noise cleaned binary image
out.bw = img;

% areas of BoundingBoxes
out.boxarea = area;

conts = out;
