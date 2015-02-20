img = imread('train14.jpg');
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

% draw contours for regions in
% thresholded image
threshed = bwareaopen(threshed,10);
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
property = conts(threshed);
[maxs row] = max([property.Area], [],2);
main_box = property(row).BoundingBox;
tester = imcrop(img, main_box);

tester = rgb2gray(tester);
threshed2 = ~ im2bw(tester,graythresh(tester));
% black = thresher(tester,100,20);
conts(threshed2);
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
