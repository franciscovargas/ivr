eval(['load ','train1/help.mat',' maxclasses Means Invcors Aprioris'])
imagestem = input('Test image file stem (filestem)\n?','s');
run=1;
imagenum=0;
while ~(run == 0)
    imagenum = imagenum + 1;
    currentimagergb = imread([imagestem, ...
    int2str(imagenum),'.jpg'],'jpg');
    currentimage = currentimagergb;
    imshow(currentimage)
    vec = extractprops(currentimage);
    class=classify(vec,maxclasses,Means,Invcors,...
    Dim,Aprioris)
    run = input(['Want to process another image',...
    int2str(imagenum+1),' (0,1)\n?']);
end



% gtf = load('GT_training.mat');
% gtf_conts = gtf.gt_training;
% suits = gtf_conts(:,1);
% [N none] = size(suits);
% N

% Dim = 3; % number of feature properties
% modelfilename = input('Model file name (filename)\n?','s');
% maxclasses = input('Number of classes (int)\n?');
% trainfilestem = input('Training image file stem (filestem)\n?', 's');
% % N = input('Number of training images (int)\n?');
% for imagenum = 1 : N
%     currentimagergb = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
%     % currentimage = rgb2gray(currentimagergb);
%     currentimage = currentimagergb;
%     vec(imagenum,:) = extractprops(currentimage);
%     % trueclasses(imagenum) = input(['Train image ', int2str(imagenum), ...
%     %                                 ' true class (1..', int2str(maxclasses), ')\n?']);
%     trueclasses(imagenum) = suits(imagenum);
% end