% main script for part one of vision
img = imread('train1.jpg');
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
vecb = reshape(normed(:,:,3),1,width*height);
% plot histograms
conts = conts(threshed);
