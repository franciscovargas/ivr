
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

if show == 1                            % TODO explain ==1
  figure
  imshow(img)
end

% Lable connecteded elements
[lable none] = bwlabel(img);

% Calculate the properties of the regions
% within the image
properties = regionprops(lable, 'all');   % TODO property -> properties?

% Retain current plots when adding new plots
if show == 1
  hold on
end

% Draw the bounding boxes in the image
[none prop_num] = size([properties.Area]);   % TODO asize
area = zeros(none, prop_num);

for n = 1 : size(properties, 1)
  delta_x = properties(n).BoundingBox(3);
  delta_y = properties(n).BoundingBox(4);
  major_ax = max(delta_x,delta_y);      % TODO mayor_ax
  min_ax = min(delta_y,delta_x);
  ratio = major_ax / min_ax;

  if ratio >= 3
    coordinate = round(properties(n).BoundingBox);
    img(coordinate(2): coordinate(2) + coordinate(4),...
        coordinate(1): coordinate(1) + coordinate(3)) = 0;
  end

  if show == 1
    rectangle('Position', ...
              properties(n).BoundingBox, ...
              'EdgeColor', ...
              'g', ...
              'LineWidth', ...
              2);
  end

  % convex = property(n).ConvexHull;
  % x = convex(:,1);
  % y = convex(:,2);
  % plot(x,y,'b');
  area(n) = properties(n).BoundingBox(3) * properties(n).BoundingBox(4);
end

% Find areas smaller than 150
small_areas = find([properties.Area] < 150);

% Display areas (in red) smaller than 150
for n = 1 : size(small_areas, 2)
  if show == 1
    rectangle('Position', ...
              properties(small_areas(n)).BoundingBox, ...
              'EdgeColor', ...
              'r', ...
              'LineWidth', ...
              2);
  end
end

% Remove the small areas
for n = 1 : size(small_areas, 2)
  
  small_coordinates = round(properties(small_areas(n)).BoundingBox);    % TODO coord?

  img(small_coordinates(2): small_coordinates(2) + small_coordinates(4), ...
      small_coordinates(1): small_coordinates(1) + small_coordinates(3)) = 0;
end

% Array structure 'prop_struct' containing:     % TODO out

% default region properties
prop_struct.prop = properties;                    % TODO out

% noise cleaned binary image
prop_struct.bw = img;

% areas of BoundingBoxes
prop_struct.boxarea = area;

conts = prop_struct;
