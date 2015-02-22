img = imread('../train2/test1.jpg');

I = rgb2gray(img);

% laplacian edge detection
threshed = edge(I, 'log');
threshed = bwareaopen(threshed,510);

% bounding box for card
out1 = conts(threshed);
property = out1.prop;
[maxs row] = max([property.Area], [], 2);
main_box = property(row).BoundingBox;
% convex_box = property(row).ConvexHull;
% cx = convex_box(:,1);
% cy = convex_box(:,2);
[th tw ch] = size(img);

main_box(1) = main_box(1) + 5;
main_box(2) = main_box(2) + 5;
main_box(3) = main_box(3) - 9;
main_box(4) = main_box(4) - 10;

tester1 = imcrop(img, main_box);
crop = imcrop(img, main_box);

figure
imshow(tester1)

% binary threshold of grayscale image
threshed2 = thresh_gray(tester1);

% noise removal via majority
threshed2 = bwmorph(threshed2, 'majority', 300);

% noise removal within the card region
out2 = conts(threshed2);
bwf = out2.bw;

% detection of suits and number
out3 = conts(bwf);
property3 = out3.prop;
[mins row3] = min([property3.Area], [], 2);
smallest = property3(row3).BoundingBox;
smallest = imcrop(crop, smallest);

figure
imshow(smallest);

[maxes row3m] = max(out3.boxarea, [], 2);
biggest = property3(row3m).BoundingBox;
biggest = imcrop(crop, biggest);

figure
imshow(biggest);
