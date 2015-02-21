img = imread('../train1/train8.jpg');
% dimensions of the image
% [height width channels] = size(img);

I = rgb2gray(img);

% J = imnoise(img,'gaussian',0.02);

% imshow(J);

% J = img;

% K = filter2(fspecial('average',10),J)/255;

% imshow(J);

% L = medfilt2(J,[3 3]);

% imshow(L);


% normalize rgb
% normed = rgbnorm(img);
% normed = img;

% imshow(normed);

% threshold normalized rgb image
% HERE BE BABY
% threshed = thresh_norm(img);

threshed = edge(I,'log');

size(threshed)
% draw contours for regions in
% thresholded image


% flatten values in redscale the two
% last parameters of reshape
% define the new dimensions of vecr
% vecr = reshape(normed(:,:,1),1,width*height);
% % same for green
% vecg = reshape(normed(:,:,2),1,width*height);
% % same for blue
% vecb = reshape(normed(:,:,3),1,width*height);
% % plot histograms
% hist(vecr,1000)
% hist(vecr,1000)
out1 = conts(threshed);
property = out1.prop;
[maxs row] = max([property.Area], [],2);
main_box = property(row).BoundingBox;
tester1 = imcrop(img, main_box);

% filter1 = fspecial('gaussian', [2,2], 6);
% tester1 = imfilter(tester1, filter1);
% tester1 = bwmorph(tester1, 'open', 1);
% figure
% imshow(threshed)

% property.BoundingBox

tester = rgb2gray(tester1);
threshed2 = ~ im2bw(tester,graythresh(tester));


threshed2 = bwmorph(threshed2, 'open', 1);
% threshed2 = bwareaopen(threshed2, 20);

% black = thresher(tester,100,20);
out2 = conts(threshed2);
bwf = out2.bw;
% for i=1:height
%     for j=1:width
%         if j > main_box(1) & j < main_box(3) +  main_box(1)...
%         & i > main_box(2) & i < main_box(4) + main_box(2)
%             % tester(i,j,1) = img(i,j,1);
%             % tester(i,j,2) = img(i,j,2);
%             % tester(i,j,3) = img(i,j,3);
%             disp('HELP');
%         else
%         	tester(i,j,1) = 0;
%             tester(i,j,2) = 0;
%             tester(i,j,3) = 0;
%         end
%     end
% end
out3 = conts(bwf);
property3 = out3.prop;
[mins row3] = min(out3.boxarea, [],2);
smallest = property3(row3).BoundingBox;
smallest = imcrop(tester1, smallest);

figure
imshow(smallest);

[maxes row3m] = max(out3.boxarea, [],2);
biggest = property3(row3m).BoundingBox;
biggest = imcrop(tester1, biggest);

figure
imshow(biggest);
