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
convex_box = property(row).ConvexHull;
cx = convex_box(:,1);
cy = convex_box(:,2);
[th tw ch] = size(img);

main_box(1) = main_box(1) + 5;
main_box(2) = main_box(2) + 5;
main_box(3) = main_box(3) - 9;
main_box(4) = main_box(4) - 10;
% main_box
% inx = round(main_box(1))
% iny = round(main_box(2))
% dx = round(main_box(4))
% dy = round(main_box(3))
% endx = (inx + dx)
% endy = (iny + dy)
% for a=iny:endy
%     for k=inx:endx
%         if ~ inpolygon(k,a,cx,cy)
%             img(k,a,1) = 255;
%             img(k,a,2) = 255;
%             img(k,a,3) = 255;
%         end
%     end
% end
figure
imshow(img)
tester1 = imcrop(img, main_box);
crop = imcrop(img, main_box);

% blurring of image
% gauss = fspecial('gaussian', [5 5], 6);
% tester1 = imfilter(tester1, gauss);

% figure
% imshow(tester1);

% for a=1:th
%     for k=1:tw
%         if inpolygon(k,a,cx,cy)
%             tester1(a,k,1) = 255;
%             tester1(a,k,2) = 255;
%             tester1(a,k,3) = 255;
%         end
%     end
% end
figure
imshow(tester1)
% binary threshold of grayscale image
threshed2 = thresh_gray(tester1);

% noise removal via open
% threshed2 = bwmorph(threshed2, 'open', 2);
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
