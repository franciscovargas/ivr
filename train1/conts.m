
function conts = countours(img)
%{
   --This function takes in a binary
   image and proceeds to find regions
   within such image.
   -- The thresholding/edge detection
   is left to be done prior to this 
   function.
   -- The pause(n) are just there
   for debugging purposes atm.
%}

% Morphological transformation
% removes open 1 valued pixels
% for a given specified size
bw = bwareaopen(img,1);

% display  binary image
imshow(bw)

% lable connecteded elements
[lable na]=bwlabel(bw);

% calculate the properties of the regions
% within the image
property= regionprops(lable);

%NOT USED. Center of mass calculation
[y x] = find( bw);
cent = [mean(x) mean(y)];

% Retain current plots when adding 
% new plots
hold on

% draw the bounding boxes in the image
for n=1:size(property,1)

    rectangle('Position',property(n).BoundingBox,'EdgeColor','g','LineWidth',2)

end

pause (3)

% find areas smaller than 500
small_areas=find([property.Area]<500);

% display areas (in red)
% smaller than 500
for n=1:size(small_areas,2)

    rectangle('Position',...
    	       property(small_areas(n)).BoundingBox, ...
    		   'EdgeColor','r','LineWidth',2)

end

pause (2)

% remove the small areas.
for n=1:size(small_areas,2)

    coord=round(property(small_areas(n)).BoundingBox);


    bw(coord(2):coord(2)+coord(4),...
       coord(1):coord(1)+coord(3))=0;

end

figure

imshow(bw)

%return region properties (along with bounding boxes)
conts = property