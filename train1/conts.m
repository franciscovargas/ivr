function conts = countours(img, show)
    %{
       -- This function takes in a binary
       image and proceeds to find regions
       within such image.
       -- The thresholding/edge detection
       is left to be done prior to this 
       function.
    %}

    [height width] = size(img);

    % Display thresholded image
    if show == 1
        figure
        imshow(img)
    end

    % Lable connecteded elements
    [lable none] = bwlabel(img);

    % Calculate the properties of the regions
    % within the image
    properties = regionprops(lable, 'all');

    % Retain current plots when adding new plots (bounding boxes)
    if show == 1
        hold on
    end

    % Number of regions
    [none prop_num] = size([properties.Area]);

    % Calculated bounding box area
    area = zeros(none, prop_num);

    % Loop through all regions
    for n = 1 : size(properties, 1)
        % Ratio of major to minor axes of bounding box
        delta_x = properties(n).BoundingBox(3);
        delta_y = properties(n).BoundingBox(4);
        major_ax = max(delta_x,delta_y);
        min_ax = min(delta_y,delta_x);
        ratio = major_ax / min_ax;

        % Remove long and thin noise
        if ratio >= 3
            coordinate = round(properties(n).BoundingBox);
            img(coordinate(2): coordinate(2) + coordinate(4), ...
                coordinate(1): coordinate(1) + coordinate(3)) = 0;
        end

        % Display bounding boxes and convex hull
        if show == 1
            rectangle('Position', ...
                    properties(n).BoundingBox, ...
                    'EdgeColor', ...
                    'g', ...
                    'LineWidth', ...
                    2);

            convex = properties(n).ConvexHull;
            x = convex(:,1);
            y = convex(:,2);
            plot(x,y,'b');
        end

        % Filling in the bounding box areas
        area(n) = properties(n).BoundingBox(3) * properties(n).BoundingBox(4);
    end

    % Find areas smaller than 150
    small_areas = find([properties.Area] < 150);

    % Display areas (in red) smaller than 150
    for n = 1 : size(small_areas, 2)
        % Display bounding boxes for small areas
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
      
        small_coordinates = round(properties(small_areas(n)).BoundingBox);

        img(small_coordinates(2): small_coordinates(2) + small_coordinates(4), ...
            small_coordinates(1): small_coordinates(1) + small_coordinates(3)) = 0;
    end

    % Array structure 'prop_struct' containing:

    % default region properties
    prop_struct.prop = properties;

    % noise cleaned binary image
    prop_struct.bw = img;

    % areas of BoundingBoxes
    prop_struct.boxarea = area;

    % Return value of the function
    conts = prop_struct;
