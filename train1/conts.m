
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
% bw = bwareaopen(img,1);
bw = img;
% dimensions
[height width] = size(img);
% [height width]
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

% [maxs row] = max([property.Area], [],2);
% main_box = property(row).BoundingBox;
% tester = zeros(height,width);
% for i=1:height
%     for j=1:width
%         if j > main_box(1) & j < main_box(3) +  main_box(1)...
%         & i > main_box(2) & i < main_box(4) + main_box(2)
%             tester(i,j) = bw(i,j);
%             disp('HELP');
%         end
%     end
% end
% imshow(tester);
% disp(main_box);
% draw the bounding boxes in the image
[none asize] = size([property.Area]);
area = zeros(none, asize);
for n=1:size(property,1)

    rectangle('Position',property(n).BoundingBox,'EdgeColor','g','LineWidth',2);
    area(n) = property(n).BoundingBox(3) * property(n).BoundingBox(4);

end

% pause (3)

% find areas smaller than 200

small_areas=find([property.Area]<200);

% display areas (in red)
% smaller than 200
for n=1:size(small_areas,2)

    rectangle('Position',...
    	       property(small_areas(n)).BoundingBox, ...
    		   'EdgeColor','r','LineWidth',2);

end

% pause (2)

% remove the small areas.
for n=1:size(small_areas,2)

    coord=round(property(small_areas(n)).BoundingBox);


    bw(coord(2):coord(2)+coord(4),...
       coord(1):coord(1)+coord(3))=0;

end

figure
imshow(bw)

out.prop = property
out.bw = bw
out.boxarea = area;
%return region properties (along with bounding boxes)
conts = out;