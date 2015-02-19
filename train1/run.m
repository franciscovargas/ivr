img = imread('train14.jpg');
% dimensions of the image
[height width channels] = size(img);
% normalize rgb
normed = rgbnorm(img);
% threshold normalized rgb image
threshed = thresh(normed);
% draw contours for regions in
% thresholded image
threshed = bwareaopen(threshed,15);
% flatten values in redscale the two
% last parameters of reshape
% define the new dimensions of vecr
vecr = reshape(normed(:,:,1),1,width*height);
% same for green
vecg = reshape(normed(:,:,2),1,width*height);
% same for blue
vecg = reshape(normed(:,:,3),1,width*height);
% plot histograms
hist(vecr,1000)
hist(vecr,1000)
property = conts(threshed);
[maxs row] = max([property.Area], [],2);
main_box = property(row).BoundingBox;
tester = imcrop(img, main_box);
black = thresher(tester,100,0);
conts(black);
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
figure
imshow(tester);
