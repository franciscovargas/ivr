gtf = load('train1/GT_training.mat');
gtf_conts = gtf.gt_training;
suits = gtf_conts(:,1);
[N none] = size(suits);
N

Dim = 3; % number of feature properties
modelfilename = input('Model file name (filename)\n?','s');
maxclasses = input('Number of classes (int)\n?');
trainfilestem = input('Training image file stem (filestem)\n?', 's');
% N = input('Number of training images (int)\n?');
for imagenum = 1 : N
    currentimagergb = imread([trainfilestem, int2str(imagenum), '.jpg'], 'jpg');
    % currentimage = rgb2gray(currentimagergb);
    currentimage = currentimagergb;
    vec(imagenum,:) = extractprops(currentimage);
    % trueclasses(imagenum) = input(['Train image ', int2str(imagenum), ...
    %                                 ' true class (1..', int2str(maxclasses), ')\n?']);
    trueclasses(imagenum) = suits(imagenum);
end
size(vec)
[Means, Invcors, Aprioris] = buildmodel(Dim, vec, N, maxclasses, trueclasses);
eval(['save ', modelfilename, ' maxclasses Means Invcors Aprioris'])